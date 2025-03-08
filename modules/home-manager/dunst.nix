{ pkgs, lib, ... }:

{
  services.dunst = {
    enable = true;
    settings = {
      global = {
        font = lib.mkForce "Iosevka Nerd Font Mono 10";
        transparency = 10;
        frame_width = 2;
        highlight = "#81a1c1";
        frame_color = lib.mkForce "#81a1c1";
      };

      urgency_low = {
        frame_color = lib.mkForce "81a1c1";
      };

      urgency_normal = {
        frame_color = lib.mkForce "81a1c1";
      };

      urgency_critical = {
        frame_color = lib.mkForce "81a1c1";
      };
    };
  };
}
