{ config, pkgs, lib, ... }:

{
  stylix.targets.rofi.enable = false;
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    extraConfig = {
      modi = "drun,run";
      show-icons = true;
      location = 0;
      drun-display-format = "{icon} {name}";
      display-drun = " Apps";
      display-run = " Run";
      display-filebrowser = " File";
      icon-theme = "Papirus";
    };
    theme =
    let
      inherit (config.lib.formats.rasi) mkLiteral;
      mkRgba = opacity: color: let
        c = config.lib.stylix.colors;
        r = c."${color}-rgb-r";
        g = c."${color}-rgb-g";
        b = c."${color}-rgb-b";
      in 
        mkLiteral
        "rgba ( ${r}, ${g}, ${b}, ${opacity}% )";
        mkRgb = mkRgba "100";
        rofiOpacity = builtins.toString (builtins.ceil (config.stylix.opacity.popups * 100));
    in lib.mkForce {
      "*" = {
        bg = mkRgba "30" "base02";
        bg-alt = mkRgba rofiOpacity "base03";
        fg = mkRgba rofiOpacity "base06";
        fg-alt = mkRgba rofiOpacity "base05";
        green = mkRgba rofiOpacity "base0B";
        blue = mkRgba rofiOpacity "base0F";
        black = mkRgb "base00";

        background-color = mkLiteral "@bg";

        border = 0;
        margin = 0;
        padding = 0;
        spacing = 0;
      };

      "window" = {
        width = mkLiteral "35%";
        border = mkLiteral "2px";
        border-color = mkLiteral "@blue";
      };

      "element" = {
        padding = 12;
        text-color = mkLiteral "@fg-alt";
        background-color = mkLiteral "@bg";
      };

      "element selected" = {
        text-color = mkLiteral "@black";
        background-color = mkLiteral "@green";
      };

      "element-text" = {
        background-color = mkLiteral "transparent";
        text-color = mkLiteral "inherit";
        vertical-align = mkLiteral "0.5";
      };

      "element-icon" = {
        size = "30px";
        background-color = mkLiteral "transparent";
      };

      "entry" = {
        background-color = mkLiteral "@bg-alt";
        padding = 12;
        text-color = mkLiteral "@fg";
        border-color = mkLiteral "@blue";
        border = "0 0 2 0";
      };

      "inputbar" = {
        children = map mkLiteral [
          "prompt"
          "entry"
        ];

      };

      "listview" = {
        background-color = mkLiteral "@bg";
        colums = 1;
        lines = 8;
      };

      "mainbox" = {
        background-color = mkLiteral "@bg";
        children = map mkLiteral [
          "inputbar"
          "listview"
        ];
      };

      "prompt" = {
        background-color = mkLiteral "@bg-alt";
        enabled = true;
        padding = mkLiteral "12 0 0 12";
        text-color = mkLiteral "@fg";
      };
    };
  };
}
