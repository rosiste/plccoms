#!/bin/sh
#
# Satrt.sh
#
# Copyright Jaroslav Vacha
# 2020/07/03 Jaroslav Vacha <rosiste@gmal.com>
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

TECO_LIB_DIR="$TECO_DIR/lib/$LIBDIR";
export LD_LIBRARY_PATH=$TECO_LIB_DIR

cd ${TECO_DIR}
exec ${TECO_DIR}/$PLCCOMS_BIN -d -c ${TECO_CONF_DIR}/PLCComS.ini -l ${TECO_LOG_DIR}/PLCComS.log
