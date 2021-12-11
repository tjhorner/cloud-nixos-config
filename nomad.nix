{ config, pkgs, ... }:
{
  virtualisation.docker.enable = true;

  services.nomad = {
    enable = true;
    enableDocker = true;

    settings = {
      datacenter = "gcp";

      acl = {
        enabled = true;
      };

      server = {
        enabled = true;
        bootstrap_expect = 1;
      };

      client = {
        enabled = true;
      };
    };
  };
}