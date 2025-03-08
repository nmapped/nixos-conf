{ pkgs, ... }:
let
  volbri-control = pkgs.writeShellScriptBin "volbri-control" ''
    #!/bin/bash
    # Configuration
    VOLUME_STEP=5
    BRIGHTNESS_STEP=5
    MAX_VOLUME=100
    NOTIFICATION_TIMEOUT=1500  # 1.5 seconds

    # Get current volume using wpctl (works with pipewire/wireplumber)
    get_volume() {
        # Extract volume percentage, scale from 0-1.0 to 0-100
        wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -oP 'Volume: \K[0-9.]+' | awk '{print int($1*100)}'
    }

    # Get mute status
    is_muted() {
        wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -q "MUTED"
    }

    # Get current brightness
    get_brightness() {
        brightnessctl g
    }

    # Get maximum brightness
    get_max_brightness() {
        brightnessctl m
    }

    # Calculate brightness percentage
    get_brightness_percent() {
        local current=$(get_brightness)
        local max=$(get_max_brightness)
        echo $((current * 100 / max))
    }

    # Send notification with progress bar (without icon)
    send_notification() {
        local value=$1
        local text=$2

        # Use dunstify for better control over notifications
        # -t timeout in milliseconds
        # -h int:value for progress bar
        # -h string:x-dunst-stack-tag for replacing notifications
        dunstify -t $NOTIFICATION_TIMEOUT \
                -h string:x-dunst-stack-tag:volume_brightness \
                -h int:value:"$value" \
                "$text"
    }

    # Volume control functions
    volume_up() {
        local current=$(get_volume)
        if [ "$current" -lt "$MAX_VOLUME" ]; then
            # Limit to max volume
            local step=$VOLUME_STEP
            if [ $((current + step)) -gt "$MAX_VOLUME" ]; then
                # Calculate exact step to reach MAX_VOLUME
                local remaining=$((MAX_VOLUME - current))
                step=$(echo "scale=2; $remaining/100" | bc)
            else
                step="$VOLUME_STEP"
            fi
            wpctl set-volume @DEFAULT_AUDIO_SINK@ "$step%+"
        fi
        show_volume_notification
    }

    volume_down() {
        wpctl set-volume @DEFAULT_AUDIO_SINK@ "$VOLUME_STEP%-"
        show_volume_notification
    }

    volume_mute() {
        wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
        show_volume_notification
    }

    # Show volume notification
    show_volume_notification() {
        local volume=$(get_volume)
        local text

        if is_muted; then
            text="Volume: Muted"
        else
            text="Volume: $volume%"
        fi

        send_notification "$volume" "$text"
    }

    # Brightness control functions
    brightness_up() {
        brightnessctl set $BRIGHTNESS_STEP%+ -q
        show_brightness_notification
    }

    brightness_down() {
        brightnessctl set $BRIGHTNESS_STEP%- -q
        show_brightness_notification
    }

    # Show brightness notification
    show_brightness_notification() {
        local brightness=$(get_brightness_percent)
        local text="Brightness: $brightness%"

        send_notification "$brightness" "$text"
    }

    # Main function
    case "$1" in
        volume_up)
            volume_up
            ;;
        volume_down)
            volume_down
            ;;
        volume_mute)
            volume_mute
            ;;
        brightness_up)
            brightness_up
            ;;
        brightness_down)
            brightness_down
            ;;
        *)
            echo "Usage: $0 {volume_up|volume_down|volume_mute|brightness_up|brightness_down}"
            exit 1
            ;;
    esac
    exit 0
  '';
in
{
  # You can choose one of these approaches:

  # 1. Return just the script:
  inherit volbri-control;

  # 2. Add as a package to your environment:
  # environment.systemPackages = [ volbri-control ];

  # 3. Add the executables to your PATH:
  # environment.pathsToLink = [ "/bin" ];
}
