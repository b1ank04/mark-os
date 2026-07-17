{pkgs, ...}: {
  programs.home-manager.enable = true;

  xdg.configFile."hypr/hyprland.conf" = {
    text = ''
      monitor = ,preferred,auto,1

      exec-once = hyprpaper
      exec-once = waybar
      exec-once = wl-paste --type text --watch cliphist store
      exec-once = wl-paste --type image --watch cliphist store
      exec-once = dunst
      exec-once = hypridle
      exec-once = nm-applet --indicator

      env = XCURSOR_THEME,catppuccin-mocha-dark-cursors
      env = XCURSOR_SIZE,24
      env = GTK_THEME,catppuccin-mocha-blue-standard+default
      env = QT_QPA_PLATFORMTHEME,qt6ct

      general {
        gaps_in = 5
        gaps_out = 10
        border_size = 2
        col.active_border = rgba(89b4faee) rgba(cba6f7ee) 45deg
        col.inactive_border = rgba(45475aaa)
        layout = dwindle
      }

      decoration {
        rounding = 10
        blur {
          enabled = true
          size = 5
          passes = 2
        }
        shadow {
          enabled = true
          range = 10
          render_power = 3
        }
      }

      animations {
        enabled = true
        bezier = snap, 0.05, 0.9, 0.1, 1
        animation = windows, 1, 2, snap
        animation = windowsOut, 1, 2, snap, popin 80%
        animation = fade, 1, 2, snap
        animation = workspaces, 1, 2, snap, slide
      }

      dwindle {
        preserve_split = true
      }

      input {
        kb_layout = us,ru
        kb_options = grp:win_shift_toggle
        follow_mouse = 1
        sensitivity = 0
      }

      misc {
        disable_hyprland_logo = true
        disable_splash_rendering = true
      }

      bind = SUPER, T, exec, kitty
      bind = SUPER, Q, killactive
      bind = SUPER, M, exit
      bind = SUPER, E, exec, nautilus
      bind = SUPER, B, exec, google-chrome-stable
      bind = SUPER, Space, exec, rofi -show drun -show-icons
      bind = SUPER, V, exec, cliphist list | rofi -dmenu | cliphist decode | wl-copy
      bind = SUPER, F, togglefloating
      bind = SUPER, J, layoutmsg, togglesplit
      bind = SUPER SHIFT, F, fullscreen
      bind = SUPER, L, exec, hyprlock

      bind = SUPER, left, movefocus, l
      bind = SUPER, right, movefocus, r
      bind = SUPER, up, movefocus, u
      bind = SUPER, down, movefocus, d
      bind = SUPER, h, movefocus, l
      bind = SUPER, k, movefocus, u

      bind = SUPER SHIFT, left, movewindow, l
      bind = SUPER SHIFT, right, movewindow, r
      bind = SUPER SHIFT, up, movewindow, u
      bind = SUPER SHIFT, down, movewindow, d
      bind = SUPER SHIFT, h, movewindow, l
      bind = SUPER SHIFT, l, movewindow, r
      bind = SUPER SHIFT, k, movewindow, u
      bind = SUPER SHIFT, j, movewindow, d

      bind = SUPER, 1, workspace, 1
      bind = SUPER, 2, workspace, 2
      bind = SUPER, 3, workspace, 3
      bind = SUPER, 4, workspace, 4
      bind = SUPER, 5, workspace, 5
      bind = SUPER, 6, workspace, 6
      bind = SUPER, 7, workspace, 7
      bind = SUPER, 8, workspace, 8
      bind = SUPER, 9, workspace, 9
      bind = SUPER, 0, workspace, 10

      bind = SUPER SHIFT, 1, movetoworkspace, 1
      bind = SUPER SHIFT, 2, movetoworkspace, 2
      bind = SUPER SHIFT, 3, movetoworkspace, 3
      bind = SUPER SHIFT, 4, movetoworkspace, 4
      bind = SUPER SHIFT, 5, movetoworkspace, 5
      bind = SUPER SHIFT, 6, movetoworkspace, 6
      bind = SUPER SHIFT, 7, movetoworkspace, 7
      bind = SUPER SHIFT, 8, movetoworkspace, 8
      bind = SUPER SHIFT, 9, movetoworkspace, 9
      bind = SUPER SHIFT, 0, movetoworkspace, 10

      bind = SUPER, mouse_down, workspace, e+1
      bind = SUPER, mouse_up, workspace, e-1

      bind = SUPER ALT, left, resizeactive, -20 0
      bind = SUPER ALT, right, resizeactive, 20 0
      bind = SUPER ALT, up, resizeactive, 0 -20
      bind = SUPER ALT, down, resizeactive, 0 20

      bindm = SUPER, mouse:272, movewindow
      bindm = SUPER, mouse:273, resizewindow

      windowrule {
        suppress_event = maximize
        match:class = .*
      }
    '';
    force = true;
  };

  xdg.configFile."hypr/hyprpaper.conf".text = ''
    preload = ~/.config/hypr/wallpaper.jpg
    wallpaper = ,~/.config/hypr/wallpaper.jpg
    splash = false
  '';

  xdg.configFile."hypr/hyprlock.conf".text = ''
    general {
      hide_cursor = true
      grace = 5
    }

    background {
      monitor =
      path = ~/.config/hypr/wallpaper.jpg
      blur_passes = 3
      blur_size = 8
    }

    input-field {
      monitor =
      size = 300, 50
      outline_thickness = 2
      dots_size = 0.25
      dots_spacing = 0.3
      outer_color = rgb(89b4fa)
      inner_color = rgb(1e1e2e)
      font_color = rgb(cdd6f4)
      fade_on_empty = true
      placeholder_text = <i>Password...</i>
      halign = center
      valign = center
    }

    label {
      monitor =
      text = $TIME
      color = rgb(cdd6f4)
      font_size = 64
      font_family = JetBrainsMono Nerd Font
      position = 0, 150
      halign = center
      valign = center
    }

    label {
      monitor =
      text = Hi, Mark
      color = rgb(89b4fa)
      font_size = 20
      font_family = JetBrainsMono Nerd Font
      position = 0, 75
      halign = center
      valign = center
    }
  '';

  xdg.configFile."hypr/hypridle.conf".text = ''
    general {
      lock_cmd = pidof hyprlock || hyprlock
      before_sleep_cmd = loginctl lock-session
      after_sleep_cmd = hyprctl dispatch dpms on
    }

    listener {
      timeout = 300
      on-timeout = hyprlock
    }

    listener {
      timeout = 600
      on-timeout = hyprctl dispatch dpms off
      on-resume = hyprctl dispatch dpms on
    }
  '';

  programs.rofi = {
    enable = true;
    package = pkgs.rofi;
    terminal = "kitty";
    theme = "catppuccin-mocha";
  };

  xdg.dataFile."rofi/themes/catppuccin-mocha.rasi".text = ''
    * {
      bg: #1e1e2e;
      bg-alt: #313244;
      fg: #cdd6f4;
      accent: #89b4fa;
      urgent: #f38ba8;

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
      placeholder-color: #6c7086;
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
    settings = [{
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
    }];
    style = ''
      * {
        font-family: "JetBrainsMono Nerd Font";
        font-size: 13px;
      }

      window#waybar {
        background-color: rgba(30, 30, 46, 0.85);
        color: #cdd6f4;
        border-bottom: 2px solid rgba(137, 180, 250, 0.3);
      }

      #workspaces button {
        padding: 0 8px;
        color: #6c7086;
        border-bottom: 2px solid transparent;
      }

      #workspaces button.active {
        color: #89b4fa;
        border-bottom: 2px solid #89b4fa;
      }

      #language {
        color: #a6e3a1;
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
        frame_color = "#89b4fa";
        font = "JetBrainsMono Nerd Font 10";
        corner_radius = 10;
      };
      urgency_normal = {
        background = "#1e1e2e";
        foreground = "#cdd6f4";
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
      foreground = "#CDD6F4";
      background = "#1E1E2E";
      selection_foreground = "#1E1E2E";
      selection_background = "#F5E0DC";
      cursor = "#F5E0DC";
      cursor_text_color = "#1E1E2E";
      url_color = "#89B4FA";
      active_tab_foreground = "#11111B";
      active_tab_background = "#CBA6F7";
      inactive_tab_foreground = "#CDD6F4";
      inactive_tab_background = "#181825";
      active_border_color = "#B4BEFE";
      inactive_border_color = "#6C7086";
      bell_border_color = "#F9E2AF";
      color0 = "#45475A";
      color1 = "#F38BA8";
      color2 = "#A6E3A1";
      color3 = "#F9E2AF";
      color4 = "#89B4FA";
      color5 = "#F5C2E7";
      color6 = "#94E2D5";
      color7 = "#BAC2DE";
      color8 = "#585B70";
      color9 = "#F38BA8";
      color10 = "#A6E3A1";
      color11 = "#F9E2AF";
      color12 = "#89B4FA";
      color13 = "#F5C2E7";
      color14 = "#94E2D5";
      color15 = "#A6ADC8";
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
      "--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8"
      "--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc"
      "--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"
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
      name = "catppuccin-mocha-blue-standard+default";
      package = pkgs.catppuccin-gtk.override {
        accents = ["blue"];
        variant = "mocha";
      };
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    cursorTheme = {
      name = "catppuccin-mocha-dark-cursors";
      package = pkgs.catppuccin-cursors.mochaDark;
      size = 24;
    };
    font = {
      name = "JetBrainsMono Nerd Font";
      size = 11;
    };
  };

  home.pointerCursor = {
    name = "catppuccin-mocha-dark-cursors";
    package = pkgs.catppuccin-cursors.mochaDark;
    size = 24;
    gtk.enable = true;
  };

  qt = {
    enable = true;
    platformTheme.name = "qt6ct";
    style.name = "kvantum";
  };

  xdg.configFile."Kvantum/kvantum.kvconfig".text = ''
    [General]
    theme=catppuccin-mocha-blue
  '';

  xdg.configFile."Kvantum/catppuccin-mocha-blue".source =
    "${pkgs.catppuccin-kvantum}/share/Kvantum/catppuccin-mocha-blue";

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
    hyprlock
    hypridle
    hyprpaper

    # theming & settings
    nwg-look
    catppuccin-gtk
    papirus-icon-theme
    catppuccin-cursors.mochaDark
    catppuccin-kvantum
    qt6Packages.qtstyleplugin-kvantum
    qt6Packages.qt6ct
    nerd-fonts.jetbrains-mono
  ];

  home.stateVersion = "26.05";
}
