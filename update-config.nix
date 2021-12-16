{ config, pkgs, ... }:
{
  systemd.services.update-nixos-config = {
    serviceConfig.Type = "oneshot";

    environment = config.nix.envVars // {
      inherit (config.environment.sessionVariables) NIX_PATH;
      HOME = "/root";
    } // config.networking.proxy.envVars;

    path = with pkgs; [ bash nix ];

    restartIfChanged = false;
    stopIfChanged = false;

    script = ''
      cd /etc/nixos
      ${pkgs.git}/bin/git pull
      ${pkgs.nixos-rebuild}/bin/nixos-rebuild switch
    '';
  };

  # systemd.timers.update-nixos-config = {
  #   wantedBy = [ "timers.target" ];
  #   partOf = [ "update-nixos-config.service" ];
  #   timerConfig = {
  #     OnCalendar = "*:0/5"; # every 5 mins
  #     Unit = "update-nixos-config.service";
  #   };
  # };
}