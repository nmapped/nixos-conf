{ config, lib, pkgs, ... }:

{
  programs.zathura = lib.mkForce {
    enable = true;
    options = {
      font = "monospace normal 12";
      default-bg = "#2E3440";
      default-fg = "#3B4252";
      statusbar-fg = "#D8DEE9";
      statusbar-bg = "#434C5E";
      inputbar-bg = "#2E3440";
      inputbar-fg = "#8FBCBB";
      notification-bg = "#2E3440";
      notification-fg = "#8FBCBB";
      notification-error-bg = "#2E3440";
      notification-error-fg = "#BF616A";
      notification-warning-bg = "#2E3440";
      notification-warning-fg = "#BF616A";
      highlight-color = "#EBCB8B";
      highlight-active-color = "#81A1C1";
      completion-bg = "#3B4252";
      completion-group-fg = "#A3BE8C";
      completion-group-bg = "#3B4252";
      completion-fg = "#81A1C1";
      completion-highlight-bg = "#81A1C1";
      recolor-lightcolor = "#2E3440";
      recolor-darkcolor = "#ECEFF4";
      recolor = false;
      recolor-keephue = false;
    };
  };
}
