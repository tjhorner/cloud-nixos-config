{ config, pkgs, ... }:
{
  services.consul = {
    enable = true;
    webUi = true;

    extraConfig = {
      server = true;
      bootstrap-expect = 3;

      datacenter = "gcp";
      retry_join = [ "provider=gce tag_value=consul-server" ];
      bind_addr = "{{ GetAllInterfaces | include \"name\" \"^eth\" | include \"flags\" \"forwardable|up\" | include \"type\" \"ipv4\" | attr \"address\" }}";

      # addresses = {
      #   http = "{{ GetAllInterfaces | include \"name\" \"^tailscale\" | include \"flags\" \"forwardable|up\" | attr \"address\" }}";
      # };

      # advertise_addr_wan = "{{ GetAllInterfaces | include \"name\" \"^tailscale\" | include \"flags\" \"forwardable|up\" | attr \"address\" }}";
    };
  };
}