{ config, pkgs, ... }:
{
  virtualisation.docker.enable = true;

  services.nomad = {
    enable = true;
    enableDocker = true;

    settings = {
      datacenter = "gcp";

      # advertise = {
      #   serf = "{{ GetAllInterfaces | include \"name\" \"^eth\" | include \"flags\" \"forwardable|up\" | attr \"address\" }}";
      # };

      # acl = {
      #   enabled = true;
      # };

      server = {
        enabled = true;

        server_join = {
          retry_join = [ "provider=gce tag_value=nomad-server" ];
        };
      };

      client = {
        enabled = true;
      };
    };
  };
}