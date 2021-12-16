{ config, pkgs, ... }:
{
  systemd.services.update-nixos-config = {
    serviceConfig.Type = "oneshot";
    path = with pkgs; [ git bash nix nixos-rebuild ];
    script = ''
      cd /etc/nixos
      git pull
      nixos-rebuild switch
    '';
  };

  systemd.timers.update-nixos-config = {
    wantedBy = [ "timers.target" ];
    partOf = [ "update-nixos-config.service" ];
    timerConfig = {
      OnCalendar = "*:0/5"; # every 5 mins
      Unit = "update-nixos-config.service";
    };
  };
}