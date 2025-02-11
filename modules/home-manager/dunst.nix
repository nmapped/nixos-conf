{ pkgs, lib, ... }:

{
  services.dunst = {
    enable = true;
    settings = {
      global = {
        font = lib.mkForce "JetBrainsMono Nerd Font Mono 10";
        transparency = 10;
        frame_width = 2;
      };
    };
  };
}
