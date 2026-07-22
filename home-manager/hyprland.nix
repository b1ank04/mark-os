{pkgs, ...}: {
  wayland.windowManager.hyprland = {
    enable = true;
    configType = "hyprlang";
    package = null;
    portalPackage = null;

    settings = {
      monitor = [
        # NAME,RESOLUTION@REFRESH,POSITION,SCALE
        "HDMI-A-1,1920x1080@200,0x0,1" # MSI MAG 255F - main, left
        "DP-1,1920x1080@144,1920x0,1" # LG 24GL600F  - secondary, right
        ",preferred,auto,1" # fallback for any other display
      ];

      "$mod" = "SUPER";
      "$terminal" = "kitty";
      "$menu" = "rofi -show drun -show-icons";
      "$browser" = "google-chrome-stable";
      "$fileManager" = "nautilus";

      # hypridle and dunst run as systemd user services (services.hypridle /
      # services.dunst), so they are not launched here. The wallpaper is set
      # with swaybg (a minimal static-wallpaper tool): it just paints the
      # image on each output as it appears, with none of hyprpaper's
      # preload/target two-step that left the desktop black on a 4K image.
      exec-once = [
        "waybar"
        "nm-applet --indicator"
        "wl-paste --type text --watch cliphist store"
        "wl-paste --type image --watch cliphist store"
        "${pkgs.swaybg}/bin/swaybg -m fill -i ${pkgs.tokyonight-wallpaper}"
      ];

      env = [
        "XCURSOR_THEME,Bibata-Modern-Ice"
        "XCURSOR_SIZE,24"
        "GTK_THEME,Tokyonight-Dark"
        "QT_QPA_PLATFORMTHEME,qt6ct"
      ];

      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 2;
        # Tokyo Night Storm: blue -> cyan accent gradient
        "col.active_border" = "rgba(7aa2f7ee) rgba(7dcfffee) 45deg";
        "col.inactive_border" = "rgba(414868aa)";
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
        bezier = "snap, 0.05, 0.9, 0.1, 1";
        animation = [
          "windows, 1, 2, snap"
          "windowsOut, 1, 2, snap, popin 80%"
          "fade, 1, 2, snap"
          "workspaces, 1, 2, snap, slide"
        ];
      };

      dwindle = {
        preserve_split = true;
      };

      input = {
        kb_layout = "us,ru";
        follow_mouse = 1;
        sensitivity = 0;
        accel_profile = "flat";
      };

      misc = {
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
      };

      bind = [
        # Apps & session
        "$mod, T, exec, $terminal"
        "$mod, Q, killactive"
        "$mod, M, exit"
        "$mod, E, exec, $fileManager"
        "$mod, B, exec, $browser"
        "$mod, Space, exec, $menu"
        "$mod, V, exec, cliphist list | rofi -dmenu | cliphist decode | wl-copy"
        "$mod, mouse:274, togglefloating"
        "$mod, S, layoutmsg, togglesplit"

        "$mod SHIFT, Return, fullscreen"
        "$mod, L, exec, hyprlock"
        "$mod SHIFT, R, exec, hyprctl reload"

        # Move focus (arrows + wasd)
        "$mod, left, movefocus, l"
        "$mod, right, movefocus, r"
        "$mod, up, movefocus, u"
        "$mod, down, movefocus, d"
        "$mod, a, movefocus, l"
        "$mod, s, movefocus, d"
        "$mod, w, movefocus, u"
        "$mod, d, movefocus, r"

        # Move window (arrows + wasd)
        "$mod SHIFT, left, movewindow, l"
        "$mod SHIFT, right, movewindow, r"
        "$mod SHIFT, up, movewindow, u"
        "$mod SHIFT, down, movewindow, d"
        "$mod SHIFT, a, movewindow, l"
        "$mod SHIFT, s, movewindow, d"
        "$mod SHIFT, w, movewindow, u"
        "$mod SHIFT, d, movewindow, r"

        # Workspaces
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

        # Move window to workspace
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

        # Scroll through workspaces
        "$mod, mouse_down, workspace, e+1"
        "$mod, mouse_up, workspace, e-1"

        # Resize active window
        "$mod ALT, left, resizeactive, -20 0"
        "$mod ALT, right, resizeactive, 20 0"
        "$mod ALT, up, resizeactive, 0 -20"
        "$mod ALT, down, resizeactive, 0 20"
      ];

      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];

      # Tap SUPER+SHIFT alone to cycle keyboard layout. As a modkey-only
      # release bind (TARGET modmask + activating key + `r` flag), Hyprland
      # auto-suppresses it whenever SUPER+SHIFT is consumed as a prefix by
      # another bind (e.g. SUPER+SHIFT+2 movetoworkspace) — so a clean tap
      # switches layout while all the WM binds keep working. `all` keeps
      # every keyboard in sync.
      bindr = [
        "SUPER SHIFT, Shift_L, exec, hyprctl switchxkblayout all next"
      ];

      # Hyprland 0.55 "windowrule v3" syntax: effects are `effect value`,
      # matchers are `match:<prop> <value>` (space-separated, not `prop:value`).
      windowrule = [
        "suppress_event maximize, match:class .*"
      ];
    };
  };

  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        hide_cursor = true;
        grace = 5;
      };

      background = [
        {
          monitor = "";
          path = "${pkgs.tokyonight-wallpaper}";
          blur_passes = 3;
          blur_size = 8;
        }
      ];

      input-field = [
        {
          monitor = "";
          size = "300, 50";
          outline_thickness = 2;
          dots_size = 0.25;
          dots_spacing = 0.3;
          outer_color = "rgb(7aa2f7)";
          inner_color = "rgb(1f2335)";
          font_color = "rgb(c0caf5)";
          fade_on_empty = true;
          placeholder_text = "<i>Password...</i>";
          halign = "center";
          valign = "center";
        }
      ];

      label = [
        {
          monitor = "";
          text = "$TIME";
          color = "rgb(c0caf5)";
          font_size = 64;
          font_family = "JetBrainsMono Nerd Font";
          position = "0, 150";
          halign = "center";
          valign = "center";
        }
        {
          monitor = "";
          text = "Hi, Mark";
          color = "rgb(7aa2f7)";
          font_size = 20;
          font_family = "JetBrainsMono Nerd Font";
          position = "0, 75";
          halign = "center";
          valign = "center";
        }
      ];
    };
  };

  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "pidof hyprlock || hyprlock";
        before_sleep_cmd = "loginctl lock-session";
        after_sleep_cmd = "hyprctl dispatch dpms on";
      };

      listener = [
        {
          timeout = 300;
          on-timeout = "hyprlock";
        }
        # DPMS-off listener removed: hyprlock v0.9.5 crashes on resume when
        # monitors are torn down/re-added (wl_display "invalid object").
        # Monitors stay powered showing the lock screen instead of blanking.
      ];
    };
  };
}
