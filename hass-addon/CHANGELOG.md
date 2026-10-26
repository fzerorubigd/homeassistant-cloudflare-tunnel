# Changelog

## 0.2.2

- Update `cloudflared` from 2024.12.2 to 2026.10.4. Cloudflare asks connectors
  to run 2026.10.2 or newer because it is removing trust in the eMudhra/emSign
  certificate authorities; older connectors may stop connecting.
- Behaviour change inherited from `cloudflared` 2026.4.0: the default
  `--edge-ip-version` is now `auto` instead of `4`, so the tunnel may connect
  over IPv6 when the host resolves it first. Hosts with broken IPv6 may see
  connection errors.

## 0.2.1

- Fix the add-on failing to start with `exec /run.sh: no such file or
  directory`. `run.sh` used a `bashio` shebang, but the image is built from
  plain Alpine, which ships neither `bashio` nor the s6 `with-contenv`
  wrapper. The script now uses a `/bin/sh` shebang, reads `cf_token` directly
  from `/data/options.json` with `jq`, and `exec`s cloudflared. The token
  guard now only fails on an unset or placeholder value; the base64 check is
  advisory and never blocks a valid token.

## 0.2.0

- Fix the architecture mapping so non-amd64 builds (aarch64, armv7, armhf, i386)
  download the correct `cloudflared` release asset instead of getting a 404.
- Mask the `cf_token` secret in the UI by switching its schema type to
  `password`.
- Fail fast with a fatal log when `cf_token` is missing or malformed instead of
  starting `cloudflared` with a token that can never connect.
- Pin the `cloudflared` version for reproducible image builds and consolidate
  the image into a single package-install layer.
- Point the add-on `url` at the correct repository.

## 0.1.0

- Initial release.
