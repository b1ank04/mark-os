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
    nixrebuild = "sudo nixos-rebuild switch --flake ~/dotfiles/nixos#mark-os";
    nixboot = "sudo nixos-rebuild boot --flake ~/dotfiles/nixos#mark-os";
    nixupdate = "nix flake update --flake ~/dotfiles/nixos && sudo nixos-rebuild switch --flake ~/dotfiles/nixos#mark-os";
    nixclean = "sudo nix-collect-garbage -d";
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.marks = import ../home-manager/home.nix;
  };
}
