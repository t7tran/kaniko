FROM alpine:3.16 as build

ENV \
    # https://github.com/mikefarah/yq/releases
    JQ_VERSION=1.6 \
    # https://github.com/mikefarah/yq/releases
    YQ_VERSION=4.29.2

RUN apk add curl tzdata
RUN mkdir -p /rootfs/usr/local/bin /rootfs/usr/share
RUN curl -fsSLo /rootfs/usr/local/bin/jq https://github.com/stedolan/jq/releases/download/jq-$JQ_VERSION/jq-linux64
RUN curl -fsSLo /rootfs/usr/local/bin/yq https://github.com/mikefarah/yq/releases/download/v$YQ_VERSION/yq_linux_amd64
RUN chmod +x /rootfs/usr/local/bin/*
RUN cp -r /usr/share/zoneinfo /rootfs/usr/share/



FROM gcr.io/kaniko-project/executor:v1.9.1-debug

COPY --from=build /rootfs /
