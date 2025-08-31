ARG BUILD_FROM=alpine:3.22.1
FROM ${BUILD_FROM}

ARG BUILD_ARCH=amd64

RUN apk add jq
RUN wget https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-${BUILD_ARCH} -O /usr/bin/cloudflared
RUN chmod +x /usr/bin/cloudflared

COPY run.sh /
RUN chmod a+x /run.sh

CMD [ "/run.sh" ]