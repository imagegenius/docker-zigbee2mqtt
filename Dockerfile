FROM ghcr.io/linuxserver/baseimage-alpine:3.16

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="Zigbee2MQTT version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="hydaz"

# environment settings
ENV ZIGBEE2MQTT_DATA="/config/zigbee2mqtt"

RUN set -xe && \
	echo "**** install build packages ****" && \
	apk add --no-cache --virtual=build-dependencies \
		g++ \
		gcc \
		git \
		jq \
		linux-headers \
		make \
		npm \
		python3 && \
	echo "**** install packages ****" && \
	apk add -U --upgrade --no-cache \
		mosquitto \
		mosquitto-clients \
		nodejs && \
	echo "**** install zigbee2mqtt ****" && \
	mkdir -p \
		/app/zigbee2mqtt \
		/tmp/zigbee2mqtt && \
	if [ -z ${VERSION+x} ]; then \
		VERSION=$(curl -sL "https://api.github.com/repos/koenkk/zigbee2mqtt/releases/latest" | \
			jq -r '.tag_name'); \
	fi && \
	curl -o \
		/tmp/zigbee2mqtt.tar.gz -L \
		"https://github.com/koenkk/zigbee2mqtt/archive/${VERSION}.tar.gz" && \
	tar xf \
		/tmp/zigbee2mqtt.tar.gz -C \
		/tmp/zigbee2mqtt --strip-components=1 && \
	cd /tmp/zigbee2mqtt && \
	npm i --save-dev @types/node && \
	npm run build && \
	mv \
		/tmp/zigbee2mqtt/node_modules \
		/tmp/zigbee2mqtt/package.json \
	 	/tmp/zigbee2mqtt/LICENSE \
	 	/tmp/zigbee2mqtt/dist \
	 	/tmp/zigbee2mqtt/index.js \
	 /app/zigbee2mqtt/ && \
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
EXPOSE 9442 1883
VOLUME /config
