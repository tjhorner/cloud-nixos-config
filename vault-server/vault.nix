{ config, pkgs, ... }:
{
  systemd.services.vault-dynamic-config = {
    enable = true;
    before = [ "vault.service" ];
    wantedBy = [ "vault.service" ];
    serviceConfig.Type = "oneshot";

    script = ''
      [ -d "/etc/vault.d/gcp.hcl" ] && exit 0

      get_metadata () {
        ${pkgs.curl}/bin/curl "http://metadata.google.internal/computeMetadata/v1/instance/attributes/$1" -H "Metadata-Flavor: Google"
      }

      KEYRING_NAME=$(get_metadata "vault-keyring-name")
      KEYRING_LOCATION=$(get_metadata "vault-keyring-location")
      SEAL_KEY_NAME=$(get_metadata "vault-seal-key")

      GCS_BUCKET=$(get_metadata "vault-gcs-bucket")
      
      PROJECT_ID=$(${pkgs.curl}/bin/curl "http://metadata.google.internal/computeMetadata/v1/project/project-id" -H "Metadata-Flavor: Google")

      mkdir -p /etc/vault.d

      cat > /etc/vault.d/gcp.hcl << EOF
      storage "gcs" {
        bucket = "$GCS_BUCKET"
      }

      seal "gcpckms" {
        project = "$PROJECT_ID"
        region = "$KEYRING_LOCATION"
        key_ring = "$KEYRING_NAME"
        crypto_key = "$SEAL_KEY_NAME"
      }
      EOF
    '';
  };

  services.vault = {
    enable = true;
    package = pkgs.vault-bin;
    address = "0.0.0.0:8200";
    storageBackend = "gcs";
    extraSettingsPaths = [ "/etc/vault.d" ];
  };
}