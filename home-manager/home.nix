{
  pkgs,
  config,
  ...
}: {
  imports = [./hyprland.nix];
  programs.home-manager.enable = true;

  programs.rofi = {
    enable = true;
    package = pkgs.rofi;
    terminal = "kitty";
    theme = "tokyonight-storm";
  };

  xdg.dataFile."rofi/themes/tokyonight-storm.rasi".text = ''
    * {
      bg: #24283b;
      bg-alt: #292e42;
      fg: #c0caf5;
      accent: #7aa2f7;
      urgent: #f7768e;

      background-color: @bg;
      text-color: @fg;
      border-color: @accent;
    }

    window {
      width: 600px;
      border: 2px;
      border-radius: 12px;
      padding: 20px;
    }

    inputbar {
      children: [ prompt, entry ];
      padding: 8px 12px;
      background-color: @bg-alt;
      border-radius: 8px;
      margin: 0 0 10px 0;
    }

    prompt {
      background-color: inherit;
      text-color: @accent;
      margin: 0 8px 0 0;
    }

    entry {
      background-color: inherit;
      placeholder: "Search...";
      placeholder-color: #565f89;
    }

    listview {
      lines: 8;
      columns: 1;
      spacing: 4px;
      fixed-height: true;
    }

    element {
      padding: 8px 12px;
      border-radius: 8px;
    }

    element selected {
      background-color: @accent;
      text-color: @bg;
    }

    element-icon {
      size: 24px;
      margin: 0 10px 0 0;
    }

    element-text {
      vertical-align: 0.5;
    }

    element selected element-icon,
    element selected element-text {
      background-color: inherit;
      text-color: inherit;
    }
  '';

  programs.waybar = {
    enable = true;
    settings = [
      {
        layer = "top";
        position = "top";
        height = 34;
        modules-left = ["hyprland/workspaces"];
        modules-center = ["clock"];
        modules-right = ["hyprland/language" "pulseaudio" "network" "cpu" "memory" "tray"];

        clock = {
          format = "{:%H:%M  %a %d %b}";
          tooltip-format = "{:%Y-%m-%d}";
        };

        "hyprland/language" = {
          format = "  {}";
          format-en = "EN";
          format-ru = "RU";
        };

        cpu = {
          format = "  {usage}%";
          interval = 5;
        };

        memory = {
          format = "  {}%";
          interval = 5;
        };

        pulseaudio = {
          format = "{icon} {volume}%";
          format-muted = " ";
          format-icons.default = ["" "" ""];
          on-click = "pavucontrol";
        };

        network = {
          format-wifi = "  {signalStrength}%";
          format-ethernet = "  {ifname}";
          format-disconnected = "  disconnected";
          tooltip-format = "{ifname}: {ipaddr}";
        };

        tray = {
          spacing = 10;
        };
      }
    ];
    style = ''
      * {
        font-family: "JetBrainsMono Nerd Font";
        font-size: 13px;
      }

      window#waybar {
        background-color: rgba(36, 40, 59, 0.85);
        color: #c0caf5;
        border-bottom: 2px solid rgba(122, 162, 247, 0.3);
      }

      #workspaces button {
        padding: 0 8px;
        color: #565f89;
        border-bottom: 2px solid transparent;
      }

      #workspaces button.active {
        color: #7aa2f7;
        border-bottom: 2px solid #7aa2f7;
      }

      #language {
        color: #7dcfff;
      }

      #clock, #cpu, #memory, #pulseaudio, #network, #language, #tray {
        padding: 0 12px;
      }
    '';
  };

  services.dunst = {
    enable = true;
    settings = {
      global = {
        width = 350;
        height = 150;
        offset = "10x10";
        origin = "top-right";
        transparency = 10;
        frame_color = "#7aa2f7";
        font = "JetBrainsMono Nerd Font 10";
        corner_radius = 10;
      };
      urgency_normal = {
        background = "#1f2335";
        foreground = "#c0caf5";
        timeout = 5;
      };
    };
  };

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
