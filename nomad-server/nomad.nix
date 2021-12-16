{ config, pkgs, ... }:
{
  virtualisation.docker.enable = true;

  systemd.services.nomad-dynamic-config = {
    enable = true;
    before = [ "nomad.service" ];
    wantedBy = [ "nomad.service" ];
    serviceConfig.Type = "oneshot";

    script = ''
      BOOTSTRAP_EXPECT=$(${pkgs.curl}/bin/curl "http://metadata.google.internal/computeMetadata/v1/instance/attributes/bootstrap-expect" -H "Metadata-Flavor: Google")
      mkdir -p /etc/nomad.d
      echo "server { bootstrap_expect = $BOOTSTRAP_EXPECT }" > /etc/nomad.d/bootstrap_expect.hcl
    '';
  };

  services.nomad = {
    enable = true;
    enableDocker = true;
    extraSettingsPaths = [ "/etc/nomad.d" ];

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