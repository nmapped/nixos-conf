{ config, pkgs, lib, ... }:

with lib; {
  programs.waybar = {
    systemd.enable = false;
    enable = true;

    settings = [
      {
        layer = "top";
        position = "top";
        modules-left = [ "custom/nixi" "hyprland/workspaces" ];
        modules-center = [ ];
        modules-right = [ 
          "custom/cpumemi"
          "cpu"
          "memory"
          "custom/padding"
          "network#icons"
          "network#name"
          "custom/padding"
          "battery#icons"
          "battery#percentage"
          "custom/padding"
          "custom/datei"
          "clock#date"
          "custom/padding"
          "custom/clocki"
          "clock#time"
          "custom/padding"
          "tray"
          "custom/padding"
        ];

        "custom/nixi" = {
          format = " 󱄅 ";
        };

        "tray" = {
          icon-size = 12;
          spacing = 10;
        };
      
        "hyprland/workspaces" = {
          format = "{icon}";
          on-scroll-up = "hyprctl dispatch workspace e+1";
          on-scroll-down = "hyprctl dispatch workspace e-1";
        };
      
        "hyprland/window" = {
          format = "{initialClass}";
          separate-outputs = true;
        };
      
        "battery#icons" = {
          interval = 60;
          states = {
            warning = 20;
            critical = 10;
          };
          format = "{icon}";
          format-charging = "󰂄";
          format-full = "󰁹";
          format-icons = {
            default = [ "󰁺" "󰁼" "󰁾" "󰂀" "󰁹" ];
            charging = "󰂄";
            full = "󰁹";
            warning = "󰂃";
            critical = "";
          };
          tooltip = false;
        };
      
        "battery#percentage" = {
            states = {
      	    warning = 20;
      	    critical = 10;
            };
            format = "{capacity}%";
            tooltip = false;
        };
      
        "network#icons" = {
          format = "{icon}";
          format-icons = {
            wifi = "󰤨";
            ethernet = "";
            disconnected = "󰤭";
          };
          tooltip = false;
        };
      
        "network#name" = {
          format = "{ifname}";
          format-wifi = "{essid}";
          format-ethernet = "{ifname}";
          format-disconnected = "no net";
          max-length = 50;
        };
      
        "clock#time" = {
          interval = 60;
          format = "{:%I:%M %p}";
        };
      
        "clock#date" = {
          format = "{:%a %d %b}";
          tooltip = false;
        };
      
        "custom/cpumemi" = {
          format = "󰘚";
          tooltip = false;
        };
      
        "custom/padding" = {
          format = " ";
          tooltip = false;
        };
      
        "custom/clocki" = {
          format = "󰥔";
          tooltip = false;
        };
      
        "custom/datei" = {
          format = "󰃭";
          tooltip = false;
        };
      }
    ];

    style = concatStrings [
      ''
        * {
          border: none;
          border-radius: 0;
          min-height: 0;
          font-family: "Iosevka Nerd Font";
          font-size: 13px;
          padding: 0;
          margin: -0.5px;
          background: none;
        }
        
        #workspaces button {
          color: #${config.lib.stylix.colors.base04};
          margin-right: 10px;
        }
        
        #workspaces button.active {
          /*background: #${config.lib.stylix.colors.base04};*/
          color: #${config.lib.stylix.colors.base0B};
        }

        window#waybar {
          padding: 0;
        }
        
        #window {
          color: #${config.lib.stylix.colors.base00};
        }
        
        #cpu, #memory, #clock.date, #clock.time, #battery.percentage, #network.name {
          background: none;
        }

        #cpu, #memory {
          color: #${config.lib.stylix.colors.base07};
        }

        #clock.date {
          color: #${config.lib.stylix.colors.base0C};
        }
        
        #clock.time {
          color: #${config.lib.stylix.colors.base09};
        }
        
        #battery.percentage {
          color: #${config.lib.stylix.colors.base0B};
        }
        
        #network.name {
          color: #${config.lib.stylix.colors.base0E};
        }
              
        #battery.icons {
          color: #${config.lib.stylix.colors.base0B};
          background: none;
          margin-left: -2px;
        }
              
        #network.icons {
          color: #${config.lib.stylix.colors.base0E};
          background: none;
        }
              
        #custom-clocki, #custom-datei, #custom-cpumemi {
          background: none;
          margin-right: 5px;
        }
        
        #custom-clocki {
          color: #${config.lib.stylix.colors.base09};
        }
        
        #custom-datei {
          color: #${config.lib.stylix.colors.base0C};
        }
        
        #custom-cpumemi {
          color: #${config.lib.stylix.colors.base07};
        }
        
        #custom-nixi {
          font-size: 20px;
          margin-right: 5px;
          margin-left: 2px;
          margin-top: -2px;
          margin-bottom: -2px;
        }

        #tray {
          background: #${config.lib.stylix.colors.base03};
          padding: 0 5px;
          margin: 2px 0 2px;
        }
      ''
    ];
  };
}
