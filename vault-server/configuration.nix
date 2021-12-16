{ config, pkgs, ... }:
{
  imports = [
    ../base.nix
    ../consul-client.nix
    ./vault.nix
  ];
}