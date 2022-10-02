## docker-zigbee2mqtt

[![docker hub](https://img.shields.io/badge/docker_hub-link-blue?style=for-the-badge&logo=docker)](https://hub.docker.com/r/hydaz/zigbee2mqtt) ![docker image size](https://img.shields.io/docker/image-size/hydaz/zigbee2mqtt?style=for-the-badge&logo=docker) [![auto build](https://img.shields.io/badge/docker_builds-automated-blue?style=for-the-badge&logo=docker?color=d1aa67)](https://github.com/hydazz/docker-zigbee2mqtt/actions?query=workflow%3A"Auto+Builder+CI")

Zigbee2MQTT - Allows you to use your Zigbee devices without the vendor's bridge or gateway. It bridges events and allows you to control your Zigbee devices via MQTT. In this way you can integrate your Zigbee devices with whatever smart home infrastructure you are using.

The default configuration should be enough to get started but you may need to change the USB device.

## Usage

```bash
docker run -d \
  --name=zigbee2mqtt \
  -e PUID=1000 \
  -e PGID=1000 \
  -e TZ=Australia/Melbourne \
  -p 9442:9442 \
  -v <path to appdata>:/config \
  --restart unless-stopped \
  hydaz/zigbee2mqtt
```

## Upgrading Zigbee2MQTT

To upgrade, all you have to do is pull the latest Docker image. We automatically check for Zigbee2MQTT updates daily. When a new version is released, we build and publish an image both as a version tag and on `:latest`.