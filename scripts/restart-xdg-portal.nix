{ pkgs, ... }:

{
  home.packages = [
    (pkgs.writeShellScriptBin "restart-xdg-portal" ''
      sleep 1
      ${pkgs.procps}/bin/pkill -e xdg-desktop-portal-hyprland || true
      ${pkgs.procps}/bin/pkill xdg-desktop-portal || true
      ${pkgs.xdg-desktop-portal-hyprland}/bin/xdg-desktop-portal-hyprland &
      sleep 2
      ${pkgs.xdg-desktop-portal}/bin/xdg-desktop-portal &
    '')
  ];
}
