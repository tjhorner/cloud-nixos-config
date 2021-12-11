{ config, pkgs, ... }:
{
  services.consul = {
    enable = true;
    webUi = true;

    extraConfig = {
      server = true;
      bootstrap = true;
      bootstrap_expect = 1;

      # bind_addr = "{{ GetAllInterfaces | include \"name\" \"^eth\" | include \"flags\" \"forwardable|up\" | attr \"address\" }}";
      # advertise_addr_wan = "{{ GetAllInterfaces | include \"name\" \"^tailscale\" | include \"flags\" \"forwardable|up\" | attr \"address\" }}";
    };
  };
}