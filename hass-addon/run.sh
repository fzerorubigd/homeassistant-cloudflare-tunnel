#!/bin/sh

# This add-on is built FROM plain Alpine, which has neither bashio nor the
# s6 "with-contenv" wrapper, so read the token straight from Home Assistant's
# add-on options file with jq (already installed in the image).
CF_TOKEN=$(jq -r '.cf_token // empty' /data/options.json)

if [ -z "$CF_TOKEN" ] || [ "$CF_TOKEN" = "UPDATE-ME" ]; then
    echo "cf_token is not set. Set it in the add-on Configuration tab." >&2
    exit 1
fi

# Non-fatal sanity check: a real cloudflared connector token base64-decodes to
# JSON. Only warn here -- never block a token that may still be valid.
if ! echo "$CF_TOKEN" | base64 -d 2>/dev/null | jq -e . >/dev/null 2>&1; then
    echo "Warning: cf_token does not look like a valid cloudflared token; starting anyway." >&2
fi

exec /usr/bin/cloudflared tunnel --no-autoupdate run --token "$CF_TOKEN"
