{ config, pkgs, lib, ... }:

{
  programs.hyprlock = {
    enable = true;
    settings = {
      background = {
        blur_size = 10;
        blur_passes = 3;
      };
      input-field = {
        size = "200, 50";
        outline_thickness = 1;
        dots_size = 0;
        dots_spacing = 5;
        dots_center = true;
        rounding = 0;
      };
    };
  };
}
