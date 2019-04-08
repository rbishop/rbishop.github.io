#! /bin/bash

token=$(< dnsimple_token.txt)

log() {
  local now=$(date +"%Y-%m-%d %H:%M:%S")
  echo "$now - $1"
}

if [ -f last_renewed_at.txt ]; then
  log "Checking for last renewal time"
  prev_renewal=$(date -f last_renewed_at.txt +"%s")
  log "SSL cert last renewed at $(< last_renewed_at.txt)"
else
  log "Last renewal time not found. Setting to 0"
  prev_renewal=0
fi

acc_id=$(curl -sS -H "Authorization: Bearer $token" https://api.dnsimple.com/v2/whoami | jq '.data.account.id')

api_updated_at=$(curl -sS \
  -H "Authorization: Bearer $token" \
  https://api.dnsimple.com/v2/$acc_id/domains/bitsandhops.com/certificates \
| jq --raw-output '.data[] | select(.common_name == "www.bitsandhops.com") | .updated_at')

updated_at=$(date -d $api_updated_at +"%s")

if [ $updated_at -gt $prev_renewal ]; then
  log "SSL cert has been renewed. Fetching new cert and key"
  cert_id=$(curl -sS \
    -H "Authorization: Bearer $token" \
    https://api.dnsimple.com/v2/$acc_id/domains/bitsandhops.com/certificates \
  | jq --raw-output '.data[] | select(.common_name == "www.bitsandhops.com") | .id')


  log "Writing certificate chain"
  curl -sS \
    -H "Authorization: Bearer $token" \
    https://api.dnsimple.com/v2/$acc_id/domains/bitsandhops.com/certificates/$cert_id/download \
  | jq --raw-output '.data | .server,.chain[0]' > /var/nginx/secrets/ssl.pem

  log "Writing private key"
  curl -sS \
    -H "Authorization: Bearer $token" \
    https://api.dnsimple.com/v2/$acc_id/domains/bitsandhops.com/certificates/$cert_id/private_key \
  | jq --raw-output '.data.private_key' > /var/nginx/secrets/ssl.key
  
  log "Updating last renewal time to $api_updated_at"
  echo $api_updated_at > last_renewed_at.txt
else
  log "SSL cert has not been renewed. Exiting."
  exit 0
fi
