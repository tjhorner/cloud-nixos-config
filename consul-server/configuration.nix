{ config, pkgs, ... }:
{
  imports = [
    ../base.nix
    ./consul.nix
  ];
}