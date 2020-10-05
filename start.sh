#!/bin/bash
#
# Start.sh
#
# Copyright Jaroslav Vacha
# 2020/10/05 Jaroslav Vacha <rosiste@gmal.com>
#

ARCH=`uname -m`
echo "PLCComS arch: $ARCH"

export MALLOC_CHECK_=4
TECO_DIR="/opt/teco";
TECO_CONF_DIR="$TECO_DIR/etc";
TECO_LOG_DIR="/var/log/teco";

case $ARCH in
    i586|i686) PLCCOMS_BIN="PLCComS"
	       LIBSDIR="lib_x86"
	       ;;
    x86_64)    PLCCOMS_BIN="PLCComS_x86_64"
	       LIBSDIR="lib_x86_64"
	       ;;
    armv6l)    PLCCOMS_BIN="PLCComS_arm_eabihf"
	       LIBSDIR="lib_rpi"
	       ;;
    armv7l)    PLCCOMS_BIN="PLCComS_arm_eabihf"
	       LIBSDIR="lib_rpi2"
	       ;;
    aarch64)   PLCCOMS_BIN="PLCComS_aarch64"
	       LIBSDIR=""
	       ;;
    *)         echo "Unknown or unsupported architecture: $ARCH"
	       exit 1
	       ;;
esac

TECO_LIB_DIR="$TECO_DIR/lib/$LIBSDIR";
export LD_LIBRARY_PATH=$TECO_LIB_DIR
echo "PLCComS LD_LIBRARY_PATH=$LD_LIBRARY_PATH"

cd ${TECO_DIR}
echo "PLCComS starting server... ${TECO_DIR}/$PLCCOMS_BIN"
./$PLCCOMS_BIN -d -c ${TECO_CONF_DIR}/PLCComS.ini -l ${TECO_LOG_DIR}/PLCComS.log
status=$?

if [ $status -ne 0 ]; then
  echo "Failed to start $PLCCOMS_BIN: $status"
  exit $status
fi

while sleep 60; do
  ps aux | grep $PLCCOMS_BIN | grep -q -v grep
  PROCESS_STATUS=$?
  if [ $PROCESS_STATUS -ne 0 ]; then
    echo "$PLCCOMS_BIN has already exited."
    exit 1
  fi
done