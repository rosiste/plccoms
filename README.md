## PLCComS
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