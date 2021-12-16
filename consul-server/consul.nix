{ config, pkgs, ... }:
{
  systemd.services.consul-dynamic-config = {
    enable = true;
    before = [ "consul.service" ];
    wantedBy = [ "consul.service" ];
    serviceConfig.Type = "oneshot";

    script = ''
      BOOTSTRAP_EXPECT=$(${pkgs.curl}/bin/curl "http://metadata.google.internal/computeMetadata/v1/instance/attributes/bootstrap-expect" -H "Metadata-Flavor: Google")
      mkdir -p /etc/consul.d
      echo "bootstrap_expect = $BOOTSTRAP_EXPECT" > /etc/consul.d/bootstrap_expect.hcl
    '';
  };

  services.consul = {
    enable = true;
    webUi = true;

    extraConfig = {
      server = true;
      datacenter = "gcp";
      retry_join = [ "provider=gce tag_value=consul-server" ];
      bind_addr = "{{ GetAllInterfaces | include \"name\" \"^eth\" | include \"flags\" \"forwardable|up\" | include \"type\" \"ipv4\" | attr \"address\" }}";
    };
  };
}