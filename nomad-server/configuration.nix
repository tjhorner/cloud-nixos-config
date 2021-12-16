{ config, pkgs, ... }:
{
  imports = [
    ../base.nix
    ./consul.nix
    ./nomad.nix
  ];
}