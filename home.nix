{ pkgs, ... }:

{
  home.username = "marks";
  home.homeDirectory = "/home/marks";
  home.stateVersion = "25.05"; # Укажите вашу версию

  programs.home-manager.enable = true;

  # Настройка терминала Kitty
  programs.kitty = {
    enable = true;
    settings = {
      font_family = "JetBrainsMono Nerd Font";
      font_size = "12";
      background_opacity = "0.9";
    };
  };

  # Настройка Zsh + плагины + zoxide
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    enableCompletion = true;
    
    initExtra = ''
      eval "$(zoxide init zsh)"
    '';
  };

  # Красивая строка приглашения (вместо громоздкого oh-my-zsh)
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };

  # Утилиты
  home.packages = with pkgs; [
    zoxide
    fzf
    ripgrep
    fd
  ];
}
