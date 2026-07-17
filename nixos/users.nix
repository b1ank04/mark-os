{pkgs, ...}: {
  users.users."marks" = {
    isNormalUser = true;
    description = "Mark Shmarov";
    extraGroups = ["networkmanager" "wheel"];
    shell = pkgs.zsh;
    packages = with pkgs; [
      kdePackages.kate
    ];
  };
  users.mutableUsers = true;

  programs.zsh.enable = true;

  environment.systemPackages = with pkgs; [
    wget
    claude-code
  ];

  environment.shellAliases = {
    # named after the nixos-rebuild subcommand each runs
    nixswitch = "sudo nixos-rebuild switch --flake ~/dotfiles/nixos#mark-os"; # apply now + set boot default
    nixboot = "sudo nixos-rebuild boot --flake ~/dotfiles/nixos#mark-os"; # apply on next reboot only
    nixtest = "sudo nixos-rebuild test --flake ~/dotfiles/nixos#mark-os"; # apply now, not in boot menu
    nixbuild = "nixos-rebuild build --flake ~/dotfiles/nixos#mark-os"; # build only, activate nothing
    nixrebuild = "sudo nixos-rebuild switch --flake ~/dotfiles/nixos#mark-os"; # compatibility alias == nixswitch
    nixupdate = "nix flake update --flake ~/dotfiles/nixos && sudo nixos-rebuild switch --flake ~/dotfiles/nixos#mark-os";
    nixclean = "sudo nix-collect-garbage -d";
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.marks = import ../home-manager/home.nix;
  };
}
