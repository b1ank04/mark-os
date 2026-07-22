{pkgs, ...}: {
  imports = [
    ./hyprland.nix
    ./waybar.nix
    ./rofi.nix
    ./dunst.nix
    ./theming.nix
    ./terminal.nix
    ./shell.nix
    ./git.nix
  ];
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    google-chrome
    micro
    zed-editor
    telegram-desktop
    jetbrains.idea
    jetbrains.goland
    jetbrains.rust-rover
    zoxide
    ripgrep
    fd
    github-copilot-cli
    microfetch

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
