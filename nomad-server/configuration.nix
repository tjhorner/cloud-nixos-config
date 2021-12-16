{ config, pkgs, ... }:
{
  imports = [
    ../base.nix
    ./nomad.nix
  ];
}