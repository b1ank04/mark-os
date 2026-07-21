{pkgs, ...}: {
  imports = [
    ./hyprland.nix
    ./waybar.nix
    ./rofi.nix
    ./dunst.nix
    ./theming.nix
  ];
  programs.home-manager.enable = true;

  programs.kitty = {
    enable = true;
    settings = {
      font_family = "JetBrainsMono Nerd Font";
      font_size = "12";
      background_opacity = "0.9";
      # Tokyo Night Storm (folke/tokyonight)
      foreground = "#c0caf5";
      background = "#24283b";
      selection_foreground = "#c0caf5";
      selection_background = "#2e3c64";
      cursor = "#c0caf5";
      cursor_text_color = "#24283b";
      url_color = "#73daca";
      active_tab_foreground = "#1f2335";
      active_tab_background = "#7aa2f7";
      inactive_tab_foreground = "#545c7e";
      inactive_tab_background = "#292e42";
      active_border_color = "#7aa2f7";
      inactive_border_color = "#292e42";
      bell_border_color = "#e0af68";
      color0 = "#1d202f";
      color1 = "#f7768e";
      color2 = "#9ece6a";
      color3 = "#e0af68";
      color4 = "#7aa2f7";
      color5 = "#bb9af7";
      color6 = "#7dcfff";
      color7 = "#a9b1d6";
      color8 = "#414868";
      color9 = "#f7768e";
      color10 = "#9ece6a";
      color11 = "#e0af68";
      color12 = "#7aa2f7";
      color13 = "#bb9af7";
      color14 = "#7dcfff";
      color15 = "#c0caf5";
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
    defaultOptions = [
      "--color=bg+:#292e42,bg:#24283b,spinner:#bb9af7,hl:#7aa2f7"
      "--color=fg:#c0caf5,header:#7aa2f7,info:#7dcfff,pointer:#bb9af7"
      "--color=marker:#9ece6a,fg+:#c0caf5,prompt:#7dcfff,hl+:#7aa2f7"
    ];
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
    jetbrains.idea
    jetbrains.goland
    zoxide
    ripgrep
    fd

    # hyprland essentials
    grim
    slurp
    wl-clipboard
    cliphist
    pavucontrol
    nautilus
    brightnessctl
    networkmanagerapplet

    # theming & settings (Tokyo Night Storm)
    nwg-look
    tokyonight-gtk-theme
    papirus-icon-theme
    bibata-cursors
    qt6Packages.qt6ct
    nerd-fonts.jetbrains-mono
  ];

  home.stateVersion = "26.05";
}
