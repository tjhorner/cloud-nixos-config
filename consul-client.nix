{ config, pkgs, ... }:
{
  services.consul = {
    enable = true;

    extraConfig = {
      datacenter = "gcp";
      retry_join = [ "provider=gce tag_value=consul-server" ];
      bind_addr = "{{ GetAllInterfaces | include \"name\" \"^eth\" | include \"flags\" \"forwardable|up\" | include \"type\" \"ipv4\" | attr \"address\" }}";
    };
  };
}