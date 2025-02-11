{ pkgs, ... }:

{
  programs.fastfetch = {
    enable = true;
    settings = {
      "$schema" = "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json";
      logo = {
        type = "kitty";
        source = "${builtins.path { path = ../../assets/nix-snowflake-colours.png;}}";
        width = 20;
      };
      modules = [
        {
          key = " user";
          type = "title";
          format = "{user-name}";
          keyColor = "31";
        }
        {
          key = "󰇅 hname";
          type = "title";
          format = "{host-name}";
          keyColor = "32";
        }
        {
          key = "󰅐 uptime";
          type = "uptime";
          keyColor = "33";
        }
        {
          key = "{icon} distro";
          type = "os";
          keyColor = "34";
        }
        {
          key = " kernel";
          type = "kernel";
          format = "{user-name}";
          keyColor = "35";
        }
        {
          key = "󰇄 desktop";
          type = "de";
          keyColor = "36";
        }
        {
          key = " term";
          type = "terminal";
          keyColor = "31";
        }
        {
          key = " shell";
          type = "shell";
          keyColor = "32";
        }
        {
          key = "󰍛 cpu";
          type = "cpu";
          showPeCoreCount = true;
          keyColor = "33";
        }
        {
          key = "󰉉 disk";
          type = "disk";
          folders = "/";
          keyColor = "34";
        }
        {
          key = " memory";
          type = "memory";
          keyColor = "35";
        }
        {
          key = " colors";
          type = "colors";
          symbol = "circle";
          keyColor = "39";
        }
      ];
    };
  };
}
