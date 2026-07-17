{pkgs, ...}: let
  # sddm-astronaut ships several variants; pick one via embeddedTheme.
  # It propagates its own Qt deps (qtsvg/qtmultimedia/qtvirtualkeyboard) and
  # does not use Qt5Compat.GraphicalEffects, so it works without Plasma.
  sddm-astronaut = pkgs.sddm-astronaut.override {
    embeddedTheme = "purple_leaves";
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
