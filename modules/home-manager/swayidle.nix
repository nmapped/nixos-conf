{ config, pkgs, lib, ... }:

{
  services.swayidle = {
    enable = true;
    systemdTarget ="hyprland-session.target";
    package = pkgs.swayidle;
    timeouts = [
      # {
      #   timeout = 300; # 6 minutes
      #   command = "${pkgs.hyprland}/bin/hyprctl dispatch dpms off";
      #   resumeCommand = "${pkgs.hyprland}/bin/hyprctl dispatch dpms on";
      # }
      # {
      #   timeout = 330;
      #   command = "${pkgs.systemd}/bin/systemctl suspend";
      # }
      {
        timeout = 360; # 5 minutes
        command = "${pkgs.hyprlock}/bin/hyprlock";
      }
    ];
    events = [
      {
        event = "before-sleep";
        command = "hyprlock";
      }
    ];
  };
}
