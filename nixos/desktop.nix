{pkgs, ...}: {
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
    theme = "catppuccin-sddm-corners";
  };

  environment.systemPackages = with pkgs; [
    catppuccin-sddm-corners
  ];

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
