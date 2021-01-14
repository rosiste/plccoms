#!/bin/bash
#
# Start.sh
#
# Copyright Jaroslav Vacha
# 2021/01/14 Jaroslav Vacha <rosiste@gmal.com>
#

ARCH=`uname -m`
echo "PLCComS arch: $ARCH"

export MALLOC_CHECK_=4
TECO_DIR="/opt/teco";
TECO_CONF_DIR="$TECO_DIR/etc";
TECO_LOG="/var/log/teco/PLCComS.log";

# create log file if not exists
touch ${TECO_LOG}

# echo the timezone
echo "Timezone set to $TZ"

# use it for script logging as well as for PLCcomS
exec >> $TECO_LOG
exec 2>> $TECO_LOG

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

echo "PLCComS binary file based on platform is $PLCCOMS_BIN"

TECO_LIB_DIR="$TECO_DIR/lib/$LIBSDIR";
export LD_LIBRARY_PATH=$TECO_LIB_DIR
echo "PLCComS LD_LIBRARY_PATH=$LD_LIBRARY_PATH"


# log the event
echo "$TECO_DIR/$PLCCOMS_BIN launching at $(date)"

# launch (do NOT use the "-d" flag)
exec "$TECO_DIR/$PLCCOMS_BIN" \
    -c "$TECO_CONF_DIR/$TECO_CONF_FILE" \
    -l "$TECO_LOG"
