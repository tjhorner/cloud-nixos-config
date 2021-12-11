{ config, pkgs, ... }:
{
  services.cron = {
    enable = true;
    systemCronJobs = [
      "*/5 * * * *      root    cd /etc/nixos && git pull origin master && nixos-rebuild switch"
    ];
  };
}