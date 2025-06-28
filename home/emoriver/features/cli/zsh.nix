{
    programs.zsh = {
    enable = true;
    enableCompletions = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
        ll = "ls -l";
        update = "sudo nixos-rebuild switch";
    };
    history.size = 10000;

    oh-my-zsh = {
        enable = true;
        plugins = [ "git" "thefuck" ];
        theme = "robbyrussell";
    };
  };
}