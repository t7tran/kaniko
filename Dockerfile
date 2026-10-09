FROM alpine:3.24.2 as build

ENV \
    # https://github.com/stedolan/jq/releases
    JQ_VERSION=1.7 \
    # https://github.com/mikefarah/yq/releases
    YQ_VERSION=4.40.5 \
    # https://github.com/google/go-containerregistry/releases
    CRANE_VERSION=0.22.1

RUN apk add curl tzdata
RUN mkdir -p /rootfs/busybox /rootfs/usr/share
RUN curl -fsSLo /rootfs/busybox/jq https://github.com/stedolan/jq/releases/download/jq-$JQ_VERSION/jq-linux64
RUN curl -fsSLo /rootfs/busybox/yq https://github.com/mikefarah/yq/releases/download/v$YQ_VERSION/yq_linux_amd64
RUN curl -fsSL https://github.com/google/go-containerregistry/releases/download/v$CRANE_VERSION/go-containerregistry_Linux_x86_64.tar.gz | tar -xzC /rootfs/busybox crane
RUN chmod +x /rootfs/busybox/*
RUN cp -r /usr/share/zoneinfo /rootfs/usr/share/



FROM ghcr.io/osscontainertools/kaniko:v1.28.5-debug

COPY --from=build /rootfs /
