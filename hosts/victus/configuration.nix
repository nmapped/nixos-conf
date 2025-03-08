# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../../disko.nix
      inputs.home-manager.nixosModules.default
      ../../modules/nixos/stylix.nix
      ../../modules/nixos/laptop-pm.nix
    ];
  
  # allow unfree software
  nixpkgs.config.allowUnfree = true;

  # nixpkgs.overlays = [
  #   (final: prev: {
  #     nvchad = inputs.nvchad4nix.packages."${pkgs.system}".nvchad;
  #   })
  # ];

  # flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # home-manager
  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      "nmapped" = import ./home.nix;
    };
    backupFileExtension = "backup";
  };

  # hyprland
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    withUWSM = true;
  };

  environment.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS  = "1";
    NIXOS_OZONE_WL = "1";
  };

  # bootloader
  boot.loader.systemd-boot.enable = false;
  boot.loader = {
    grub = {
      enable = true;
      useOSProber = true;
      efiSupport = true;
      device = "nodev";
    };
    efi = {
      canTouchEfiVariables = true;
    };
  };

  # zsh system-wide install
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  # firefox
  programs.firefox.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    neovim
    wget
    bat
    kmonad
    brightnessctl
    git
    direnv
    libnotify
    dunst
    waybar
    (waybar.overrideAttrs (oldAttrs: { mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ]; }))
    wl-clipboard
    kitty
    rofi-wayland
    (import ../../scripts/volume-control.nix { inherit pkgs; }).volume-control
    (import ../../scripts/brightness-control.nix { inherit pkgs; }).brightness-control
  ];

  # desktop portals
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-hyprland pkgs.xdg-desktop-portal-gtk ];

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # timezone
  time.timeZone = "Africa/Lagos";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  # Enable the X11 windowing system.
  # services.xserver.enable = true;

  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # printing
  services.printing.enable = true;
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  # sound
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    jack.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
  };
  security.rtkit.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  # age
  age.secrets.nmapped-nixpass.file = ./secrets/nmapped-nixpass.age;

  # users
  users.users.nmapped = {
    isNormalUser = true;
    extraGroups = [ "wheel" "input" "networkmanager" ];
    hashedPasswordFile = config.age.secrets.nmapped-nixpass.path;
    # packages = [ pkgs.nvchad ];
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware = {
    bluetooth.enable = true;
    graphics.enable = true;
    nvidia = {
      modesetting.enable = true;
      powerManagement.enable = false;
      powerManagement.finegrained = false;
      open = true;
      nvidiaSettings = true;
      prime = {
        amdgpuBusId = "PCI:7:0:0";
        nvidiaBusId = "PCI:1:0:0";
        offload = {
          enable = true;
          enableOffloadCmd = true;
        };
      };
      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };
  };

  systemd.services.kmonad-laptop = {
    description = "kmonad laptop kb remap";
    wantedBy = [ "multi-user.target" ];
    after = [ "network.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.kmonad}/bin/kmonad /home/nmapped/.config/kmonad/config.kbd";
      Restart = "always";
      User = "root";
      Group = "root";
    };
  };

  systemd.services.kmonad-ext = let
    device_name = "usb-Razer_Razer_Huntsman_Mini_00000000001A-event-kbd";
  in {
    description = "kmonad razer kb remap";
    wantedBy = [ "multi-user.target" ];
    after = [ "network.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.bash}/bin/bash -c '${pkgs.writeShellScript "ext-kmonad"
      ''
      if [[ -e "/dev/input/by-id/${device_name}" ]]; then
        ${pkgs.kmonad}/bin/kmonad /home/nmapped/.config/kmonad/extconfig.kbd
      fi
      ''}'";
      Restart = "always";
      User = "root";
      Group = "root";
    };
  };

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.11"; # Did you read the comment?

}

