{ config, lib, pkgs, ... }:

{
  services.gmediarender = {
    enable = true;
    name = "NixOS Cast";
  };
}
