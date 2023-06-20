# Download base image Linux Debian
FROM debian:bullseye
LABEL maintainer "Jaroslav Vacha <rosiste@gmail.com>"

# Define the ports the container will listen on
EXPOSE 5010

# Define the ENV variables
ENV TECO_DIR="/opt/teco"
ENV TECO_CONF_DIR="/etc/teco"
ENV TECO_LIB_DIR="/opt/teco/lib"
ENV TECO_LOG_DIR="/var/log/teco"
ENV TECO_CONF_FILE="PLCComS.ini"
ENV TECO_LOG_FILE="PLCComS.log"
ENV FOXTROT_CONF_FILE="FIXED_Foxtrot.pub"
ENV TZ="Europe/Prague"

# Set the working directory.
WORKDIR ${TECO_DIR}

# Create directory
RUN mkdir -p ${TECO_DIR}
RUN mkdir -p ${TECO_DIR}/etc_defaults
RUN mkdir -p ${TECO_CONF_DIR}
RUN mkdir -p ${TECO_LOG_DIR}
RUN mkdir -p ${TECO_LIB_DIR}/lib_rpi
RUN mkdir -p ${TECO_LIB_DIR}/lib_rpi2
RUN mkdir -p ${TECO_LIB_DIR}/lib_x86
RUN mkdir -p ${TECO_LIB_DIR}/lib_x86_64

# Install utils
RUN apt update && apt upgrade -y && apt install -y ntp && apt install -y tzdata

# Copy binary file
COPY bin/* ${TECO_DIR}/
RUN chmod 700 ${TECO_DIR}/PLCComS*
COPY start.sh ${TECO_DIR}/start.sh
RUN chmod 700 ${TECO_DIR}/start.sh

# Copy lib file
COPY lib/lib_rpi/libcrypto.so.1.0.0 ${TECO_LIB_DIR}/lib_rpi
COPY lib/lib_rpi2/libcrypto.so.1.0.0 ${TECO_LIB_DIR}/lib_rpi2
COPY lib/lib_x86/libcrypto.so.1.1 ${TECO_LIB_DIR}/lib_x86
COPY lib/lib_x86_64/libcrypto.so.1.1 ${TECO_LIB_DIR}/lib_x86_64

# Copy PLCComS default configuration
COPY etc/${TECHO_CONF_FILE} ${TECO_DIR}/etc_defaults
COPY etc/${FOXTROT_CONF_FILE} ${TECO_DIR}/etc_defaults

# Volume configuration
VOLUME ["/var/log/teco", "/etc/teco"]

# Start PLCComS
ENTRYPOINT ["/opt/teco/start.sh"]

# EOF
