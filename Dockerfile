# syntax=docker/dockerfile:1

FROM ghcr.io/imagegenius/baseimage-alpine:edge

# set version label
ARG BUILD_DATE
ARG VERSION
ARG ZIGBEE2MQTT_VERSION
LABEL build_version="ImageGenius Version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="hydazz"

# environment settings
ENV ZIGBEE2MQTT_DATA="/config/"

RUN \
  echo "**** install build packages ****" && \
  apk add --no-cache --virtual=build-dependencies \
    g++ \
    gcc \
    git \
    linux-headers \
    libcap \
    make \
    npm \
    python3 && \
  echo "**** install packages ****" && \
  apk add -U --upgrade --no-cache \
    nodejs && \
  npm install -g \
    pnpm@10.4.1 && \
  echo "**** install zigbee2mqtt ****" && \
  mkdir -p \
    /app/zigbee2mqtt \
    /tmp/zigbee2mqtt && \
  if [ -z ${ZIGBEE2MQTT_VERSION+x} ]; then \
    ZIGBEE2MQTT_VERSION=$(curl -sL "https://api.github.com/repos/koenkk/zigbee2mqtt/releases/latest" | \
      jq -r '.tag_name'); \
  fi && \
  curl -o \
    /tmp/zigbee2mqtt.tar.gz -L \
    "https://github.com/koenkk/zigbee2mqtt/archive/${ZIGBEE2MQTT_VERSION}.tar.gz" && \
  tar xf \
    /tmp/zigbee2mqtt.tar.gz -C \
    /tmp/zigbee2mqtt --strip-components=1 && \
  cd /tmp/zigbee2mqtt && \
  pnpm install --frozen-lockfile --no-optional && \
  npm run build && \
  mv \
    /tmp/zigbee2mqtt/node_modules \
    /tmp/zigbee2mqtt/package.json \
    /tmp/zigbee2mqtt/LICENSE \
    /tmp/zigbee2mqtt/dist \
    /tmp/zigbee2mqtt/index.js \
    /app/zigbee2mqtt/ && \
  echo "**** set capabilities for node ****" && \
  setcap 'cap_net_bind_service=+ep' /usr/bin/node && \
  echo "**** cleanup ****" && \
  apk del --purge \
    build-dependencies && \
  rm -rf \
    /tmp/* \
    /root/.cache \
    /root/.npm

# copy local files
COPY root/ /

# ports and volumes
EXPOSE 9442
VOLUME /config
