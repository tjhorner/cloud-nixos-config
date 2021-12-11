{ config, pkgs, ... }:
{
  virtualisation.docker.enable = true;

  services.nomad = {
    enable = true;
    enableDocker = true;

    settings = {
      datacenter = "gcp";

      advertise = {
        http = "{{ GetAllInterfaces | include \"name\" \"^tailscale\" | include \"flags\" \"forwardable|up\" | attr \"address\" }}";
        rpc = "{{ GetAllInterfaces | include \"name\" \"^eth\" | include \"flags\" \"forwardable|up\" | attr \"address\" }}";
        serf = "{{ GetAllInterfaces | include \"name\" \"^tailscale\" | include \"flags\" \"forwardable|up\" | attr \"address\" }}";
      };

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