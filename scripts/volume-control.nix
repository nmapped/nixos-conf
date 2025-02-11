{ pkgs, ... }:

let
  icons = {
    high = ../assets/dunst/volume-high.png;
    low = ../assets/dunst/volume-low.png;
    off = ../assets/dunst/volume-off.png;
    mute = ../assets/dunst/volume-mute.png;
  };

  volume-control = pkgs.writeShellScriptBin "volume-control" ''
    # Get the script's directory
    SCRIPT_DIR="$(${pkgs.coreutils}/bin/dirname "$(${pkgs.coreutils}/bin/readlink -f "$0")")"
    
    # Set icon paths relative to script location
    ICON_VOLUME_HIGH="${icons.high}"
    ICON_VOLUME_LOW="${icons.low}"
    ICON_VOLUME_OFF="${icons.off}"
    ICON_VOLUME_MUTE="${icons.mute}"

    # Helper function to display a Dunst notification with a progress bar
    send_notification() {
        local icon=$1
        local title=$2
        local percentage=$3
        
        # Create progress bar
        local bar_length=$((percentage / 5))
        local progress_bar=""
        for ((i=0; i<bar_length; i++)); do
            progress_bar+="─"
        done
        
        ${pkgs.dunst}/bin/dunstify \
            -i "$icon" \
            -r 9994 \
            -u low \
            "$title" \
            "$progress_bar $percentage%"
    }

    # Volume Control with wpctl (wireplumber)
    change_volume() {
        local direction=$1
        local change=$2
        
        if [[ $direction == "toggle" ]]; then
            # Toggle mute
            ${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
        else
            # Increase or decrease volume
            ${pkgs.wireplumber}/bin/wpctl set-volume @DEFAULT_AUDIO_SINK@ "$change"
        fi
        
        # Get current volume and mute status
        local raw_volume=$(${pkgs.wireplumber}/bin/wpctl get-volume @DEFAULT_AUDIO_SINK@)
        local volume=$(echo "$raw_volume" | awk '{print int($2 * 100)}')
        local is_muted=$(echo "$raw_volume" | grep -o "MUTED")
        
        # Determine the volume icon
        local icon="$ICON_VOLUME_OFF"
        if [[ -n "$is_muted" || $volume -eq 0 ]]; then
            icon="$ICON_VOLUME_MUTE"
            volume=0
        elif [[ $volume -lt 50 ]]; then
            icon="$ICON_VOLUME_LOW"
        else
            icon="$ICON_VOLUME_HIGH"
        fi
        
        # Send notification
        send_notification "$icon" "Volume" "$volume"
    }

    # Main script logic
    case $1 in
        up)
            change_volume "+" "5%+"
            ;;
        down)
            change_volume "-" "5%-"
            ;;
        toggle)
            change_volume "toggle"
            ;;
        *)
            echo "Usage: $0 {up|down|toggle}"
            ;;
    esac
  '';
in
{
  inherit volume-control;
}
