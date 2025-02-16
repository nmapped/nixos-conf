{ config, pkgs, inputs, ... }:

{

  imports = [
    ../../modules/home-manager/firefox.nix
    ../../modules/home-manager/hyprland.nix
    ../../modules/home-manager/stylix.nix
    ../../modules/home-manager/waybar.nix
    ../../modules/home-manager/nvchad.nix
    ../../modules/home-manager/fastfetch.nix
    ../../modules/home-manager/dunst.nix
    ../../modules/home-manager/shell.nix
    ../../modules/home-manager/rofi.nix
    ../../modules/home-manager/spotify.nix
    ../../modules/home-manager/emacs.nix
    ../../modules/home-manager/zathura.nix
    inputs.nvchad4nix.homeManagerModule
    ../../scripts/restart-xdg-portal.nix
  ];

  # allow unfree
  nixpkgs.config.allowUnfree = true;

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "nmapped";
  home.homeDirectory = "/home/nmapped";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    bun
    pandoc
    cargo
    nodejs_23
    grim
    slurp
    swappy
    btop
    nerd-fonts.symbols-only
    eza
    mpv
    feh
    obs-studio
    unzip
    spotify-player
    qbittorrent-enhanced
    vesktop
    zathura

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/nmapped/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # kitty
  programs.kitty = {
    enable = true;
    shellIntegration.mode = "no-cursor";
    settings = {
      font_size = 12;
      disable_ligatures = "never";
      text_composition_strategy = "platform";
      cursor_trail = 1;
      window_padding_width = 4;
    };
  };

  # git
  programs.git = {
    userEmail = "yaegereren835@gmail.com";
    userName = "nmapped";
    extraConfig = {
      init.defaultBranch = "main";
    };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
