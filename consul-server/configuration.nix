{ config, pkgs, ... }:
{
  imports = [
    ./base.nix
    ./consul-server/consul.nix
  ];
}