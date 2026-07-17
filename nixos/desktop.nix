{pkgs, ...}: let
  # sddm-astronaut ships several variants; pick one via embeddedTheme.
  # It propagates its own Qt deps (qtsvg/qtmultimedia/qtvirtualkeyboard) and
  # does not use Qt5Compat.GraphicalEffects, so it works without Plasma.
  #
  # themeConfig is written by the package as `<theme>.conf.user`, which SDDM
  # auto-loads to override the base theme's keys — so we keep the purple_leaves
  # layout but recolor everything to Tokyo Night Storm. Background is the same
  # store-managed wallpaper the desktop/lock screen use; the /nix/store path is
  # world-readable so the sddm user can load it directly. A file:// URL is used
  # because the theme feeds the string straight into a QML Image.source.
  sddm-astronaut = pkgs.sddm-astronaut.override {
    embeddedTheme = "purple_leaves";
    themeConfig = {
      # Background (same wallpaper as the desktop and lock screen)
      Background = "file://${pkgs.tokyonight-wallpaper}";
      CropBackground = "true";
      DimBackground = "0.35";
      DimBackgroundColor = "#1a1b26";
      PartialBlur = "true";
      HaveFormBackground = "true";
      FormBackgroundColor = "#1f2335";
      BackgroundColor = "#24283b";

      # Text
      HeaderTextColor = "#c0caf5";
      DateTextColor = "#a9b1d6";
      TimeTextColor = "#c0caf5";

      # Input fields
      LoginFieldBackgroundColor = "#292e42";
      PasswordFieldBackgroundColor = "#292e42";
      LoginFieldTextColor = "#c0caf5";
      PasswordFieldTextColor = "#c0caf5";
      PlaceholderTextColor = "#565f89";
      UserIconColor = "#7aa2f7";
      PasswordIconColor = "#7aa2f7";

      # Buttons / accents
      WarningColor = "#f7768e";
      LoginButtonTextColor = "#1f2335";
      LoginButtonBackgroundColor = "#7aa2f7";
      SystemButtonsIconsColor = "#c0caf5";
      SessionButtonTextColor = "#c0caf5";
      VirtualKeyboardButtonTextColor = "#c0caf5";

      # Dropdown
      DropdownTextColor = "#c0caf5";
      DropdownSelectedBackgroundColor = "#7aa2f7";
      DropdownBackgroundColor = "#1f2335";

      # Highlight
      HighlightTextColor = "#1f2335";
      HighlightBackgroundColor = "#7aa2f7";
      HighlightBorderColor = "#7aa2f7";

      # Hover (cyan)
      HoverUserIconColor = "#7dcfff";
      HoverPasswordIconColor = "#7dcfff";
      HoverSystemButtonsIconsColor = "#7dcfff";
      HoverSessionButtonTextColor = "#7dcfff";
      HoverVirtualKeyboardButtonTextColor = "#7dcfff";
    };
  };
in {
  # Wayland compositor. programs.hyprland automatically wires up the
  # xdg-desktop-portal-hyprland portal, polkit, XWayland and the SDDM
  # session entry, so none of that needs to be declared by hand.
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # Login manager: SDDM in Wayland mode.
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    theme = "sddm-astronaut-theme";
    # QML libraries the greeter theme needs at runtime.
    extraPackages = [sddm-astronaut];
  };

  # Theme must also be installed system-wide so SDDM can find it under
  # /run/current-system/sw/share/sddm/themes.
  environment.systemPackages = [sddm-astronaut];

  # Keymap for the greeter / XWayland clients.
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # hyprlock authenticates via PAM; without this service it cannot unlock.
  security.pam.services.hyprlock = {};

  services.printing.enable = true;

  # Audio via PipeWire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
}
