{ config, pkgs, ... }:
{
  imports = [
    <nixpkgs/nixos/modules/virtualisation/google-compute-image.nix>
    ./nomad.nix
    ./update-config.nix
  ];

  environment.systemPackages = with pkgs; [
    git
  ];

  system.autoUpgrade.enable = true;
}