## Supported Architectures:

Architectures officially supported by this Docker container:

![Linux x86/i686](https://img.shields.io/badge/linux/386-yellowgreen)
![Linux x86-64](https://img.shields.io/badge/linux/amd64-yellowgreen)
![ARMv8 64-bit](https://img.shields.io/badge/linux/arm64-yellowgreen)
![ARMv7 32-bit](https://img.shields.io/badge/linux/arm/v7-yellowgreen)
![ARMv6 32-bit](https://img.shields.io/badge/linux/arm/v6-yellowgreen)

## PLCComS
![GitHub last commit](https://img.shields.io/github/last-commit/rosiste/plccoms)
![Docker Image Size (tag)](https://img.shields.io/docker/image-size/rosiste/plccoms/latest)

Dockerized PLCComS - Communication server for TECO PLC (Foxtrot, TC700 and SoftPLC)

## Function
Communication server provide TCP/IP connection with client device and a PLC. Communication of server with client is created by simple text oriented protocol - question/answer. Server communicates with PLS optimalized by EPSNET protocol

- **[PLCComS (SW) EN](https://www.tecomat.com/download/software-and-firmware/plccoms/)** - PLCComS - Communication server
- **[PLCComS (SW) CZ](https://www.tecomat.cz/ke-stazeni/software/plccoms/)** - PLCComS - komunikacni server

## How to Run this container

### Running from Docker Hub

```
# pull from docker hub
$> docker pull rosiste/plccoms

# run ntp
$> docker run --name=plccoms            \
              --restart=always      \
              --detach              \
              --publish=5001:5001/tcp \
              --e TZ=Europe/Prague    \
              rosiste/plccoms

```
There is necessary to modify configuration file PLCComS.ini in volume /opt/teco/etc.


## Author

Jaroslav Vacha