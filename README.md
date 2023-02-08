<!-- DO NOT EDIT THIS FILE MANUALLY  -->

# [imagegenius/zigbee2mqtt](https://github.com/imagegenius/docker-zigbee2mqtt)

[![GitHub Release](https://img.shields.io/github/release/imagegenius/docker-zigbee2mqtt.svg?color=007EC6&labelColor=555555&logoColor=ffffff&style=for-the-badge&logo=github)](https://github.com/imagegenius/docker-zigbee2mqtt/releases)
[![GitHub Package Repository](https://shields.io/badge/GitHub%20Package-blue?logo=github&logoColor=ffffff&style=for-the-badge)](https://github.com/imagegenius/docker-zigbee2mqtt/packages)
[![Jenkins Build](https://img.shields.io/jenkins/build?labelColor=555555&logoColor=ffffff&style=for-the-badge&jobUrl=https%3A%2F%2Fci.imagegenius.io%2Fjob%2FDocker-Pipeline-Builders%2Fjob%2Fdocker-zigbee2mqtt%2Fjob%2Fmain%2F&logo=jenkins)](https://ci.imagegenius.io/job/Docker-Pipeline-Builders/job/docker-zigbee2mqtt/job/main/)

Zigbee2MQTT allows you to use your Zigbee devices without the vendor's bridge or gateway.

[![zigbee2mqtt](https://www.zigbee2mqtt.io/logo.png)](https://www.zigbee2mqtt.io/)

## Supported Architectures

We use Docker manifest for cross-platform compatibility. More details can be found on [Docker's website](https://github.com/docker/distribution/blob/master/docs/spec/manifest-v2-2.md#manifest-list).

To obtain the appropriate image for your architecture, simply pull `ghcr.io/imagegenius/zigbee2mqtt:latest`. Alternatively, you can also obtain specific architecture images by using tags.

This image supports the following architectures:

| Architecture | Available | Tag |
| :----: | :----: | ---- |
| x86-64 | ✅ | amd64-\<version tag\> |
| arm64 | ❌ | |

## Application Setup

The default configuration should be enough to get started but you may need to change the USB device in /config/configuration.yaml

## Usage

Example snippets to start creating a container:

### Docker Compose

```yaml
---
version: "2.1"
services:
  zigbee2mqtt:
    image: ghcr.io/imagegenius/zigbee2mqtt:latest
    container_name: zigbee2mqtt
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=Australia/Melbourne
    volumes:
      - path_to_appdata:/config
    ports:
      - 9442:9442
    devices:
      - /dev/ttyUSB0:Zigbee USB
    restart: unless-stopped
```

### Docker CLI ([Click here for more info](https://docs.docker.com/engine/reference/commandline/cli/))

```bash
docker run -d \
  --name=zigbee2mqtt \
  -e PUID=1000 \
  -e PGID=1000 \
  -e TZ=Australia/Melbourne \
  -p 9442:9442 \
  -v path_to_appdata:/config \
  --device /dev/ttyUSB0:Zigbee USB \
  --restart unless-stopped \
  ghcr.io/imagegenius/zigbee2mqtt:latest
```

## Container Variables

To configure the container, pass variables at runtime using the format `<external>:<internal>`. For instance, `-p 8080:80` exposes port `80` inside the container, making it accessible outside the container via the host's IP on port `8080`.

| Variable | Description |
| :----: | --- |
| `-p 9442` | WebUI Port |
| `-e PUID=1000` | for UserID - see below for explanation |
| `-e PGID=1000` | for GroupID - see below for explanation |
| `-e TZ=Australia/Melbourne` | Specify a timezone to use, eg. Australia/Melbourne |
| `-v /config` | Appdata Path |
| `--device Zigbee USB` | Path the the Zigbee USB, usually /dev/ttyUSB0 or /dev/ttyACM0 |

## Umask for running applications

All of our images allow overriding the default umask setting for services started within the containers using the optional -e UMASK=022 option. Note that umask works differently than chmod and subtracts permissions based on its value, not adding. For more information, please refer to the Wikipedia article on umask [here](https://en.wikipedia.org/wiki/Umask).

## User / Group Identifiers

To avoid permissions issues when using volumes (`-v` flags) between the host OS and the container, you can specify the user (`PUID`) and group (`PGID`). Make sure that the volume directories on the host are owned by the same user you specify, and the issues will disappear.

Example: `PUID=1000` and `PGID=1000`. To find your PUID and PGID, run `id user`.

```bash
  $ id username
    uid=1000(dockeruser) gid=1000(dockergroup) groups=1000(dockergroup)
```

## Updating the Container

Most of our images are static, versioned, and require an image update and container recreation to update the app. We do not recommend or support updating apps inside the container. Check the [Application Setup](#application-setup) section for recommendations for the specific image.

Instructions for updating containers:

### Via Docker Compose

* Update all images: `docker-compose pull`
  * or update a single image: `docker-compose pull zigbee2mqtt`
* Let compose update all containers as necessary: `docker-compose up -d`
  * or update a single container: `docker-compose up -d zigbee2mqtt`
* You can also remove the old dangling images: `docker image prune`

### Via Docker Run

* Update the image: `docker pull ghcr.io/imagegenius/zigbee2mqtt:latest`
* Stop the running container: `docker stop zigbee2mqtt`
* Delete the container: `docker rm zigbee2mqtt`
* Recreate a new container with the same docker run parameters as instructed above (if mapped correctly to a host folder, your `/config` folder and settings will be preserved)
* You can also remove the old dangling images: `docker image prune`

## Versions

* **02.01.23:** - Initial Release.
