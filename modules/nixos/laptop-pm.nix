{ config, lib, pkgs, ... }:

{
  services.system76-scheduler.settings.cfsProfiles.enable = true;

  services.tlp = {
    enable = true;
    settings = {
      CPU_BOOST_ON_AC = 1;
      CPU_BOOST_ON_BAT = 0;
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
    };
  };

  powerManagement.powertop.enable = true;
}
