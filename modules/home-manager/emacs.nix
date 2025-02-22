{ pkgs, inputs, lib, ... }:
let
  emacs = with pkgs; (emacsPackagesFor (emacs29-pgtk.override { withXwidgets = true; })).emacsWithPackages (epkgs: with epkgs; [
    treesit-grammars.with-all-grammars
    vterm
    mu4e
  ]);
in
{
  nixpkgs.overlays = [ (import inputs.emacs-overlay) ];

  home.packages = with pkgs; [
    ## Emacs itself
    binutils            # native-comp needs 'as', provided by this
    emacs               # HEAD + native-comp

    ## Doom dependencies
    git
    ripgrep
    gnutls              # for TLS connectivity

    ## Optional dependencies
    fd                  # faster projectile indexing
    imagemagick         # for image-dired
    zstd                # for undo-fu-session/undo-tree compression
    webkitgtk
    python3
    python3Packages.pynput
    python3Packages.pyqt5
    python3Packages.pyside2

    ## Module dependencies
    # :email mu4e
    mu
    isync
    # :checkers spell
    (aspellWithDicts (ds: with ds; [ en en-computers en-science ]))
    # :tools editorconfig
    editorconfig-core-c # per-project style config
    # :tools lookup & :lang org +roam
    sqlite
    # :lang cc
    clang-tools
    # :lang latex & :lang org (latex previews)
    texlive.combined.scheme-medium
    # :lang nix
    age
  ];

  xdg.desktopEntries.emacs-debug = {
    name = "Emacs (Debug Mode)";
    icon = "emacs";
    exec = "${emacs}/bin/emacs --debug-init";
  };

  home.sessionVariables.PATH = "$XDG_CONFIG_HOME/emacs/bin:$PATH";
}
