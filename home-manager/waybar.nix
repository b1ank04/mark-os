{...}: {
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
}
