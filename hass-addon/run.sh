#!/usr/bin/with-contenv bashio

# The cloudflared connector token is a base64-encoded JSON document. Decode and
# parse it up front: if it is missing or malformed, fail instead of starting
# cloudflared with a token that can never connect.
CF_TOKEN=$(bashio::config 'cf_token')

if ! echo "${CF_TOKEN}" | base64 -d - 2>/dev/null | jq -e . &> /dev/null; then
    bashio::log.fatal "The cf_token is not valid. Set a valid token in the Configuration tab."
    bashio::exit.nok
fi

/usr/bin/cloudflared tunnel --no-autoupdate run --token "${CF_TOKEN}"
