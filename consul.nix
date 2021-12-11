{ config, pkgs, ... }:
{
  services.consul = {
    enable = true;
    webUi = true;

    # extraConfig = {
    #   bind = "{{ GetAllInterfaces | include \"name\" \"^tailscale\" | include \"flags\" \"forwardable|up\" | attr \"address\" }}";
    # };
  };
}