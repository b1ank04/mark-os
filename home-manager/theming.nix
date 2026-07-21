{
  pkgs,
  config,
  ...
}: {
  gtk = {
    enable = true;
    theme = {
      name = "Tokyonight-Dark";
      package = pkgs.tokyonight-gtk-theme;
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    cursorTheme = {
      name = "Bibata-Modern-Ice";
      package = pkgs.bibata-cursors;
      size = 24;
    };
    font = {
      name = "JetBrainsMono Nerd Font";
      size = 11;
    };
  };

  home.pointerCursor = {
    name = "Bibata-Modern-Ice";
    package = pkgs.bibata-cursors;
    size = 24;
    gtk.enable = true;
  };

  # No Tokyo Night Kvantum theme exists in nixpkgs 26.05, so instead of
  # vendoring an out-of-tree Kvantum theme we drive Qt's built-in Fusion
  # style from a custom qt6ct palette. Zero external deps, cannot rot.
  qt = {
    enable = true;
    platformTheme.name = "qt6ct";
    style.name = "Fusion";
    qt6ctSettings = {
      Appearance = {
        style = "Fusion";
        icon_theme = "Papirus-Dark";
        standard_dialogs = "default";
        custom_palette = true;
        color_scheme_path = "${config.xdg.configHome}/qt6ct/colors/TokyoNightStorm.conf";
      };
    };
  };

  # qt6ct custom palette (Tokyo Night Storm). 21 QPalette roles per group,
  # order: WindowText, Button, Light, Midlight, Dark, Mid, Text, BrightText,
  # ButtonText, Base, Window, Shadow, Highlight, HighlightedText, Link,
  # LinkVisited, AlternateBase, NoRole, ToolTipBase, ToolTipText,
  # PlaceholderText. Colors are #AARRGGBB.
  xdg.configFile."qt6ct/colors/TokyoNightStorm.conf".text = ''
    [ColorScheme]
    active_colors=#ffc0caf5, #ff24283b, #ff414868, #ff3b4261, #ff16161e, #ff292e42, #ffc0caf5, #ffffffff, #ffc0caf5, #ff1f2335, #ff24283b, #ff000000, #ff7aa2f7, #ff1f2335, #ff7dcfff, #ffbb9af7, #ff292e42, #ffc0caf5, #ff1f2335, #ffc0caf5, #80565f89
    disabled_colors=#ff565f89, #ff24283b, #ff414868, #ff3b4261, #ff16161e, #ff292e42, #ff565f89, #ffffffff, #ff565f89, #ff1f2335, #ff24283b, #ff000000, #ff292e42, #ff565f89, #ff7dcfff, #ffbb9af7, #ff292e42, #ff565f89, #ff1f2335, #ffc0caf5, #80565f89
    inactive_colors=#ffc0caf5, #ff24283b, #ff414868, #ff3b4261, #ff16161e, #ff292e42, #ffc0caf5, #ffffffff, #ffc0caf5, #ff1f2335, #ff24283b, #ff000000, #ff7aa2f7, #ff1f2335, #ff7dcfff, #ffbb9af7, #ff292e42, #ffc0caf5, #ff1f2335, #ffc0caf5, #80565f89
  '';
}
