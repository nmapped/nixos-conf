{ pkgs, ... }:

let
  # Define icon paths relative to this .nix file
  icons = {
    brightness = ../assets/dunst/brightness.png;
  };
  
  brightness-control = pkgs.writeShellScriptBin "brightness-control" ''
    # Set icon path from Nix store
    ICON_BRIGHTNESS="${icons.brightness}"

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
            -r 9993 \
            -u low \
            "$title" \
            "$progress_bar $percentage%"
    }

    # Brightness Control with brightnessctl
    change_brightness() {
        local direction=$1
        local change=$2
        
        # Change brightness
        ${pkgs.brightnessctl}/bin/brightnessctl set "$change" -q
        
        # Get current brightness percentage
        local brightness=$(${pkgs.brightnessctl}/bin/brightnessctl get)
        local max_brightness=$(${pkgs.brightnessctl}/bin/brightnessctl max)
        local brightness_percent=$((brightness * 100 / max_brightness))
        
        # Send notification
        send_notification "$ICON_BRIGHTNESS" "Brightness" "$brightness_percent"
    }

    # Main script logic
    case $1 in
        up)
            change_brightness "+" "5%+"
            ;;
        down)
            change_brightness "-" "5%-"
            ;;
        *)
            echo "Usage: $0 {up|down}"
            ;;
    esac
  '';
in
{
  inherit brightness-control;
}
