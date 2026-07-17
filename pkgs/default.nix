# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example'
pkgs: {
  # example = pkgs.callPackage ./example { };

  # Tokyo Night wallpaper (cafe-at-night cityscape, 4K) from the official
  # tokyo-night/wallpapers repo, pinned by commit + hash. Shared by hyprpaper,
  # hyprlock and the SDDM greeter so desktop/lock/login use one wallpaper.
  # It resolves to a /nix/store path (world-readable), so the greeter — which
  # runs as the unprivileged sddm user and cannot read ~/.config — can load it
  # directly with no copy step.
  tokyonight-wallpaper = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/tokyo-night/wallpapers/9a72582d7505da9a28b2fd77c155fbf140f6c8f0/misc/cityscape/cafe-at-night_00_3840x2160.png";
    hash = "sha256-e2qEtH09Wrg3vBxljPmH3FNC9x7IugnAWScOwswNSZw=";
  };
}
