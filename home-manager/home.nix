{pkgs, ...}: {
  programs.home-manager.enable = true;

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      monitor = ",preferred,auto,1";

      "$mod" = "SUPER";
      "$terminal" = "kitty";
      "$menu" = "wofi --show drun";
      "$browser" = "google-chrome-stable";
      "$filemanager" = "nautilus";

      exec-once = [
        "waybar"
        "hyprpaper"
        "wl-paste --type text --watch cliphist store"
        "wl-paste --type image --watch cliphist store"
        "dunst"
      ];

      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 2;
        "col.active_border" = "rgba(89b4faee) rgba(cba6f7ee) 45deg";
        "col.inactive_border" = "rgba(45475aaa)";
        layout = "dwindle";
      };

      decoration = {
        rounding = 10;
        blur = {
          enabled = true;
          size = 5;
          passes = 2;
        };
        shadow = {
          enabled = true;
          range = 10;
          render_power = 3;
        };
      };

      animations = {
        enabled = true;
        bezier = "ease, 0.25, 0.1, 0.25, 1";
        animation = [
          "windows, 1, 4, ease"
          "windowsOut, 1, 4, ease, popin 80%"
          "fade, 1, 4, ease"
          "workspaces, 1, 4, ease"
        ];
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      input = {
        kb_layout = "us";
        follow_mouse = 1;
        sensitivity = 0;
      };

      bind = [
        "$mod, Return, exec, $terminal"
        "$mod, Q, killactive"
        "$mod, M, exit"
        "$mod, E, exec, $filemanager"
        "$mod, B, exec, $browser"
        "$mod, Space, exec, $menu"
        "$mod, V, exec, cliphist list | wofi --dmenu | cliphist decode | wl-copy"
        "$mod, F, togglefloating"
        "$mod, P, pseudo"
        "$mod, J, togglesplit"
        "$mod SHIFT, F, fullscreen"

        # screenshot
        ", Print, exec, grim -g \"$(slurp)\" - | wl-copy"
        "SHIFT, Print, exec, grim - | wl-copy"

        # move focus
        "$mod, left, movefocus, l"
        "$mod, right, movefocus, r"
        "$mod, up, movefocus, u"
        "$mod, down, movefocus, d"
        "$mod, h, movefocus, l"
        "$mod, l, movefocus, r"
        "$mod, k, movefocus, u"
        "$mod, j, movefocus, d"

        # move windows
        "$mod SHIFT, left, movewindow, l"
        "$mod SHIFT, right, movewindow, r"
        "$mod SHIFT, up, movewindow, u"
        "$mod SHIFT, down, movewindow, d"
        "$mod SHIFT, h, movewindow, l"
        "$mod SHIFT, l, movewindow, r"
        "$mod SHIFT, k, movewindow, u"
        "$mod SHIFT, j, movewindow, d"

        # workspaces
        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"
        "$mod, 6, workspace, 6"
        "$mod, 7, workspace, 7"
        "$mod, 8, workspace, 8"
        "$mod, 9, workspace, 9"
        "$mod, 0, workspace, 10"

        # move to workspace
        "$mod SHIFT, 1, movetoworkspace, 1"
        "$mod SHIFT, 2, movetoworkspace, 2"
        "$mod SHIFT, 3, movetoworkspace, 3"
        "$mod SHIFT, 4, movetoworkspace, 4"
        "$mod SHIFT, 5, movetoworkspace, 5"
        "$mod SHIFT, 6, movetoworkspace, 6"
        "$mod SHIFT, 7, movetoworkspace, 7"
        "$mod SHIFT, 8, movetoworkspace, 8"
        "$mod SHIFT, 9, movetoworkspace, 9"
        "$mod SHIFT, 0, movetoworkspace, 10"

        # scroll through workspaces
        "$mod, mouse_down, workspace, e+1"
        "$mod, mouse_up, workspace, e-1"

        # resize with mod + alt + arrows
        "$mod ALT, left, resizeactive, -20 0"
        "$mod ALT, right, resizeactive, 20 0"
        "$mod ALT, up, resizeactive, 0 -20"
        "$mod ALT, down, resizeactive, 0 20"
      ];

      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];

      windowrulev2 = [
        "suppressevent maximize, class:.*"
      ];
    };
  };

  programs.waybar = {
    enable = true;
    settings = [{
      layer = "top";
      position = "top";
      height = 34;
      modules-left = ["hyprland/workspaces"];
      modules-center = ["clock"];
      modules-right = ["pulseaudio" "network" "cpu" "memory" "battery" "tray"];

      clock = {
        format = "{:%H:%M  %a %d %b}";
        tooltip-format = "{:%Y-%m-%d}";
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

      #clock, #cpu, #memory, #pulseaudio, #network, #tray {
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

  programs.wofi = {
    enable = true;
    settings = {
      show = "drun";
      width = 500;
      height = 400;
      always_parse_args = true;
      show_all = true;
      print_command = true;
      insensitive = true;
    };
    style = ''
      window {
        background-color: rgba(30, 30, 46, 0.95);
        border: 2px solid #89b4fa;
        border-radius: 10px;
      }

      #input {
        background-color: #313244;
        color: #cdd6f4;
        border: none;
        border-radius: 8px;
        padding: 8px 12px;
        margin: 8px;
      }

      #entry:selected {
        background-color: #89b4fa;
        color: #1e1e2e;
        border-radius: 8px;
      }
    '';
  };

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
    jetbrains.idea
    jetbrains.goland
    zoxide
    ripgrep
    fd

    # hyprland essentials
    hyprpaper
    grim
    slurp
    wl-clipboard
    cliphist
    pavucontrol
    nautilus
    brightnessctl
    networkmanagerapplet
  ];

  home.stateVersion = "26.05";
}
