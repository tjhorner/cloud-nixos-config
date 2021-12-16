{ config, pkgs, ... }:
{
  imports = [
    ./base.nix
    ./nomad-server/nomad.nix
  ];
}