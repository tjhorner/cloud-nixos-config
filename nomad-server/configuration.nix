{ config, pkgs, ... }:
{
  imports = [
    ../base.nix
    ../consul-client.nix
    ./nomad.nix
  ];
}