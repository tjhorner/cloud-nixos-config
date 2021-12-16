{ config, pkgs, ... }:
{
  services.consul = {
    enable = true;

    extraConfig = {
      datacenter = "gcp";
      bind_addr = "{{ GetAllInterfaces | include \"name\" \"^eth\" | include \"flags\" \"forwardable|up\" | attr \"address\" }}";
    };
  };
}