{ config, pkgs, lib, ... }

{
  textfox = {
    enable = true;
    profile = "firefox profile name here";
    config = {
      background = {
        color = "#2E3440"; // Nord Polar Night darkest blue-black
      };
      border = {
        color = "#81A1C1"; // Nord Frost 1 - calm blue
        width = "4px";
        transition = "1.0s ease";
        radius = "3px";
      };
      displayHorizontalTabs = true;
      displayWindowControls = true;
      displayNavButtons = true;
      displayUrlbarIcons = true;
      displaySidebarTools = false;
      displayTitles = false;
      newtabLogo = "   **            **  ____          \A   / /____  *  *_/ /_/ **/**_  *  *_\A  / **/ ***** \\| |/*****/ **/ /_/ __ \\| |/_/\A / /_/  __/>  </ /_/ __/ /_/ />  <  \A \\__/\\___/_/|_|\\__/_/  \\____/_/|_|  ";
      font = {
        family = "Fira Code";
        size = "15px";
        accent = "#88C0D0"; // Nord Frost 2 - lighter blue
      };
      sidebery = {
        margin = "1.0rem";
      };
    };
  };
}
