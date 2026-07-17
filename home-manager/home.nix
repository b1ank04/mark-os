{pkgs, ...}: {
  programs.home-manager.enable = true;

  programs.kitty = {
    enable = true;
    settings = {
      font_family = "JetBrainsMono Nerd Font";
      font_size = "12";
      background_opacity = "0.9";
    };
  };

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    enableCompletion = true;
    initContent = ''
      eval "$(zoxide init zsh)"
    '';
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.git = {
    enable = true;
    settings = {
      user.name = "Mark Shmarov";
      user.email = "shmarov.mark@gmail.com";
      init.defaultBranch = "main";
      pull.rebase = true;
    };
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  home.packages = with pkgs; [
    google-chrome
    micro
    zed-editor
    telegram-desktop
    jetbrains.idea-ultimate
    jetbrains.goland
    zoxide
    ripgrep
    fd
  ];

  home.stateVersion = "25.11";
}
