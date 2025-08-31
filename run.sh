#!/usr/bin/with-contenv bashio

# Create main config
CF_TOKRN=$(bashio::config 'cf_token')
/usr/bin/cloudflared tunnel --no-autoupdate run --token ${CF_TOKEN}