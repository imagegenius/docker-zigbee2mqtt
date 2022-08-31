## docker-zigbee2mqtt (+mosquitto)

[![docker hub](https://img.shields.io/badge/docker_hub-link-blue?style=for-the-badge&logo=docker)](https://hub.docker.com/r/vcxpz/zigbee2mqtt) ![docker image size](https://img.shields.io/docker/image-size/vcxpz/zigbee2mqtt?style=for-the-badge&logo=docker) [![auto build](https://img.shields.io/badge/docker_builds-automated-blue?style=for-the-badge&logo=docker?color=d1aa67)](https://github.com/hydazz/docker-zigbee2mqtt/actions?query=workflow%3A"Auto+Builder+CI")

**This is an unofficial image that has been modified for my own needs. If my needs match your needs, feel free to use this image at your own risk.**

This is an image featuring Zigbee2MQTT and Mosquitto all-in-one, the default configuration should be enough to get started but you may need to change the USB device.

Zigbee2MQTT - Allows you to use your Zigbee devices without the vendor's bridge or gateway. It bridges events and allows you to control your Zigbee devices via MQTT. In this way you can integrate your Zigbee devices with whatever smart home infrastructure you are using.

Mosquitto is an open source implementation of a server for the MQTT protocol

## Usage

```bash
docker run -d \
  --name=zigbee2mqtt \
  --cap-add=NET_ADMIN \
  -e PUID=1000 \
  -e PGID=1000 \
  -e TZ=Australia/Melbourne \
  -p 9442:9442 #z2m webui \
  -p 1883:1883 #mqtt \
  -v <path to appdata>:/config \
  --restart unless-stopped \
  vcxpz/zigbee2mqtt
```

## Upgrading Zigbee2MQTT

To upgrade, all you have to do is pull the latest Docker image. We automatically check for Zigbee2MQTT updates daily. When a new version is released, we build and publish an image both as a version tag and on `:latest`.