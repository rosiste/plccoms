#!/bin/bash
#
# Start.sh
#
# Copyright Jaroslav Vacha
# 2021/01/15 Jaroslav Vacha <rosiste@gmal.com>
#
echo "$(date) - ** Dockerized PLCComS - Communication server for TECO PLC (Foxtrot, TC700 and SoftPLC) **"

# define the path to the log file
TECO_LOG="$TECO_LOG_DIR/$TECO_LOG_FILE"

# create log file if not exists
touch ${TECO_LOG}

# get platform architecture string
ARCH=`uname -m`
echo "$(date) - PLCComS arch: $ARCH"

export MALLOC_CHECK_=4
#TECO_DIR="/opt/teco";
#TECO_CONF_DIR="$TECO_DIR/etc";
#TECO_LOG=$TECO_LOG_DIR/$TECO_LOG_FILE;

# echo the timezone
echo "$(date) - Timezone set to $TZ"

# use it for script logging as well as for PLCcomS
#exec >> $TECO_LOG
#exec 2>> $TECO_LOG

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

echo "$(date) - PLCComS binary file based on platform is set to $PLCCOMS_BIN"

TECO_LIB_DIR="$TECO_DIR/lib/$LIBSDIR";
export LD_LIBRARY_PATH=$TECO_LIB_DIR
echo "$(date) - PLCComS LD_LIBRARY_PATH is set to $LD_LIBRARY_PATH"

# define function to restore missing configuration files
restoreConfigurationFile ()
{

   if [ ! -e "$TECO_CONF_DIR/$1" ] ; then

      echo "$(date) - $1 missing from $TECO_CONF_DIR - initialising default"
      cp -a "$TECO_DIR/$1" "$TECO_CONF_DIR/$1"

   fi

}

# ensure configuration files are restored on first run
restoreConfigurationFile "$TECO_CONF_FILE"
restoreConfigurationFile "$FOXTROT_CONF_FILE"

# launch PLCComS binary
echo "$(date) - launching PLCComS binary from $TECO_DIR/$PLCCOMS_BIN"

# launch (do NOT use the "-d" flag)
exec "$TECO_DIR/$PLCCOMS_BIN" \
    -c "$TECO_CONF_DIR/$TECO_CONF_FILE" \
    -l "$TECO_LOG"
