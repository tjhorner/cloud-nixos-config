{ config, pkgs, ... }:
{
  imports = [
    <nixpkgs/nixos/modules/virtualisation/google-compute-image.nix>
    ./nomad.nix
  ];

  system.autoUpgrade.enable = true;
}