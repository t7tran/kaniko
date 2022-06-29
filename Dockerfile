FROM alpine:3.15 as build

ENV \
    # https://github.com/mikefarah/yq/releases
    JQ_VERSION=1.6 \
    # https://github.com/mikefarah/yq/releases
    YQ_VERSION=4.25.3

RUN apk add curl
RUN mkdir /build
RUN curl -fsSLo /build/jq https://github.com/stedolan/jq/releases/download/jq-$JQ_VERSION/jq-linux64
RUN curl -fsSLo /build/yq https://github.com/mikefarah/yq/releases/download/v$YQ_VERSION/yq_linux_amd64
RUN chmod +x /build/*

FROM gcr.io/kaniko-project/executor:v1.8.1-debug

COPY --from=build /build/* /usr/local/bin/