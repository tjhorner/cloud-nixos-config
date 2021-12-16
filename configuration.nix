{ config, pkgs, ... }:
{
  imports = [
    <nixpkgs/nixos/modules/virtualisation/google-compute-image.nix>
    ./base.nix
    ./tailscale.nix
    ./consul.nix
    ./nomad.nix
    ./update-config.nix
  ];

  environment.systemPackages = with pkgs; [
    git
  ];

  system.autoUpgrade.enable = true;
}