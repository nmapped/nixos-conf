{ config, pkgs, lib, ... }:

{
  services.swayidle = {
    enable = true;
    timeouts = [
      {
        timeout = 300; # 5 minutes
        command = "hyprlock";
      }
      {
        timeout = 360; # 6 minutes
        command = "hyprctl dispatch dpms off";
        resumeCommand = "hyprctl dispatch dpms on";
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
