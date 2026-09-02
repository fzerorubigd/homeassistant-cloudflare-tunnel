ARG BUILD_FROM=alpine:3.22.1
FROM ${BUILD_FROM}

ARG BUILD_ARCH=amd64
ARG CLOUDFLARED_VERSION=2024.12.2

RUN apk add --no-cache jq

# Home Assistant's BUILD_ARCH names do not match cloudflared's release asset
# names, so a plain "cloudflared-linux-${BUILD_ARCH}" download 404s on any
# non-amd64 build. Map HA arch -> cloudflared asset before downloading.
RUN case "${BUILD_ARCH}" in \
        aarch64) CF_ARCH="arm64" ;; \
        amd64)   CF_ARCH="amd64" ;; \
        armhf)   CF_ARCH="armhf" ;; \
        armv7)   CF_ARCH="arm" ;; \
        i386)    CF_ARCH="386" ;; \
        *) echo "Unsupported architecture: ${BUILD_ARCH}" >&2; exit 1 ;; \
    esac \
    && wget "https://github.com/cloudflare/cloudflared/releases/download/${CLOUDFLARED_VERSION}/cloudflared-linux-${CF_ARCH}" -O /usr/bin/cloudflared \
    && chmod +x /usr/bin/cloudflared

COPY run.sh /
RUN chmod a+x /run.sh

CMD [ "/run.sh" ]
