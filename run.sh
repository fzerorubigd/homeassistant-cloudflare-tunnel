#!/usr/bin/with-contenv bashio

# Create main config
CF_TOKEN=$(bashio::config 'cf_token')
echo ${CF_TOKEN} | base64 -d -  2>&1 | jq &> /dev/null || echo "Make sure the token is valid (set it in configure tab)"
/usr/bin/cloudflared tunnel --no-autoupdate run --token ${CF_TOKEN}