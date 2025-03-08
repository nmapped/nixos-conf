{ config, pkgs, ... }:

{
  # hyprland
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = false;

    settings = {

	    general = {
	      gaps_in = 0;
	      gaps_out = 0;
	      border_size = 2;
	      # "col.active_border" = "rgba(b9b9b9ff)";
	      # "col.inactive_border" = "rgba(00000000)";
	      resize_on_border = false;
	      allow_tearing = false;
	      layout = "dwindle";
	    };

	    decoration = {
	      rounding = 0;
	      rounding_power = 2;
	      active_opacity = 1.0;
	      inactive_opacity = 1.0;
	      shadow = {
		      enabled = false;
		      range = 4;
		      render_power = 3;
		      # color = "rgba(1a1a1aee)";
	      };

	      blur = {
		      enabled = true;
		      size = 3;
		      passes = 1;

		      vibrancy = 0.1696;
	      };
	    };

	    animations = {
	      enabled = "no, please :)";

	      bezier = [
          "easeOutQuint,0.23,1,0.32,1"
	        "easeInOutCubic,0.65,0.05,0.36,1"
	        "linear,0,0,1,1"
	        "almostLinear,0.5,0.5,0.75,1.0"
	        "quick,0.15,0,0.1,1"
	      ];

	      animation = [
	        "global, 1, 10, default"
	        "border, 1, 5.39, easeOutQuint"
	        "windows, 1, 4.79, easeOutQuint"
	        "windowsIn, 1, 4.1, easeOutQuint, popin 87%"
	        "windowsOut, 1, 1.49, linear, popin 87%"
	        "fadeIn, 1, 1.73, almostLinear"
	        "fadeOut, 1, 1.46, almostLinear"
	        "fade, 1, 3.03, quick"
	        "layers, 1, 3.81, easeOutQuint"
	        "layersIn, 1, 4, easeOutQuint, fade"
	        "layersOut, 1, 1.5, linear, fade"
	        "fadeLayersIn, 1, 1.79, almostLinear"
	        "fadeLayersOut, 1, 1.39, almostLinear"
	        "workspaces, 1, 1.94, almostLinear, fade"
	        "workspacesIn, 1, 1.21, almostLinear, fade"
	        "workspacesOut, 1, 1.94, almostLinear, fade"
	      ];

	    };

      # layer rules
      layerrule = [
        "blur, rofi"
      ];

	    #"Smart gaps" / "No gaps when only"
	    # workspace = w[tv1], gapsout:0, gapsin:0
	    # workspace = f[1], gapsout:0, gapsin:0
	    # windowrulev2 = bordersize 0, floating:0, onworkspace:w[tv1]
	    # windowrulev2 = rounding 0, floating:0, onworkspace:w[tv1]
	    # windowrulev2 = bordersize 0, floating:0, onworkspace:f[1]
	    # windowrulev2 = rounding 0, floating:0, onworkspace:f[1]

	    # Example windowrule v1
	    # windowrule = float, ^(kitty)$

	    windowrulev2 = [
	      # See-through kitty
	      "opacity 0.95 0.8,initialClass:^(kitty)$"

        # See-through emacs
        "opacity 0.95 0.8,initialClass:^(emacs)$"

        # See-through waybar
        # "opacity 0.95,initialClass:^(waybar)$"

	      # Ignore maximize requests from apps. You'll probably like this.
	      "suppressevent maximize, class:.*"

	      # Fix some dragging issues with XWayland
	      "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"

	      "float,title:^(Picture-in-Picture)$"
	      "pin,title:^(Picture-in-Picture)$"
	    ];

	    dwindle = {
	      pseudotile = true; # Master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
	      preserve_split = true; # You probably want this
	    };

	    # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
	    master = {
	      new_status = "master";
	    };

	    # https://wiki.hyprland.org/Configuring/Variables/#misc
	    misc = {
	      force_default_wallpaper = 0; # Set to 0 or 1 to disable the anime mascot wallpapers
	      disable_hyprland_logo = true; # If true disables the random hyprland logo / anime girl background. :(
	    };

	    monitor = [
        "eDP-1, 1920x1080@60, 0x0, 1"
        "HDMI-A-1, 1920x1080@60, auto, 1"
	    ];

      "$mainMod" = "ALT"; # Sets "Windows" key as main modifier

      "$terminal" = "kitty";
      "$fileManager" = "dolphin";
      "$menu" = "rofi -show drun";
      "$shot" = ''grim -g "$(slurp)" - | wl-copy'';
      "$editshot" = ''grim -g "$(slurp)" - | swappy -f -'';

	    bind = [
        "$mainMod, Return, exec, $terminal"
        "$mainMod, Q, killactive,"
        "$mainMod SHIFT, Q, exit,"
        "$mainMod, D, exec, $menu"
        "$mainMod, E, exec, emacsclient -c -a \"\""
        "$mainMod, Space, togglefloating,"
        "$mainMod, R, exec, $menu"
        "$mainMod, P, pseudo, # dwindle"
        "$mainMod, V, togglesplit, # dwindle"
        "$mainMod SHIFT, C, exec, $editshot"
        "$mainMod, C, exec, $shot"
        "$mainMod, F, fullscreen"

        # Move focus with mainMod + vim keys
        "$mainMod, H, movefocus, l"
        "$mainMod, L, movefocus, r"
        "$mainMod, K, movefocus, u"
        "$mainMod, J, movefocus, d"

        # Move windows with mainMod + vim keys
        "$mainMod SHIFT, H, movewindow, l"
        "$mainMod SHIFT, L, movewindow, r"
        "$mainMod SHIFT, K, movewindow, u"
        "$mainMod SHIFT, J, movewindow, d"

        # Switch workspaces with mainMod + [0-9]
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"

        # Move active window to a workspace with mainMod + SHIFT + [0-9]
        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"

        # Example special workspace (scratchpad)
        "$mainMod, S, togglespecialworkspace, magic"
        "$mainMod SHIFT, S, movetoworkspace, special:magic"

        # Scroll through existing workspaces with mainMod + scroll
        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"
	    ];

      # Move/resize windows with mainMod + LMB/RMB and dragging
      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
	    ];

      # Laptop multimedia keys for volume and LCD brightness
	    bindel = [
        ",XF86AudioRaiseVolume, exec, volbri-control volume_up"
        ",XF86AudioLowerVolume, exec, volbri-control volume_down"
        ",XF86AudioMute, exec, volbri-control volume_mute"
        ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        ",XF86MonBrightnessUp, exec, brightness_up"
        ",XF86MonBrightnessDown, exec, brightness_down"
        "$mainMod, bracketright, exec, brightness_up"
        "$mainMod, bracketleft, exec, brightness_down"

        # Requires playerctl
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPause, exec, playerctl play-pause"
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioPrev, exec, playerctl previous"
	    ];

      input = {
        kb_layout = "us";
        # kb_variant = "";
        # kb_model = "";
        # kb_options = "";
        # kb_rules = "";

        follow_mouse = 1;

        sensitivity = 0; # -1.0 - 1.0, 0 means no modification.

        touchpad = {
        	natural_scroll = true;
        };
      };

      gestures = {
        workspace_swipe = false;
      };

      device = {
        name = "epic-mouse-v1";
        sensitivity = -0.5;
      };

      cursor = {
        no_hardware_cursors = true;
      };

	    env = [
        "XCURSOR_SIZE,20"
        "HYPRCURSOR_SIZE,20"
	    ];

	    exec-once = [
	      "restart-xdg-portal"
	      "waybar &"
        "dunst"
        # "waybar & hyprpaper"
	    ];
    };
  }; 
}
