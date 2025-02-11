{ pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    oh-my-zsh.enable = true;
    oh-my-zsh.theme = "half-life";
    oh-my-zsh.plugins = [
      "git"
    ];
    shellAliases = {
      ls = "eza --icons=always";
      ll = "eza --long --all --group --icons=always";
      tree = "eza -T --icons=always";
      grep = "grep --color=auto";
      ff = "fastfetch";
    };
    initExtra = ''
      _hidden() {
        nohup "$@" > /dev/null 2>&1 & disown
      }

      if [[ $INSIDE_EMACS = 'vterm' ]]; then
        export PS1="%F{#81A1C1}%n@%m%f %F{#88C0D0}%~%f λ "
      fi
      '';
  };
}
