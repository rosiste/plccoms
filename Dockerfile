# Download base image Linux Debian
FROM debian
LABEL maintainer "Jaroslav Vacha <rosiste@gmail.com>"

# Define the ENV variable
ENV TECO_DIR /opt/teco
ENV TECO_CONF_DIR /opt/teco/etc
ENV TECO_LIB_DIR /opt/teco/lib
ENV TECO_LOG_DIR /var/log/teco
ENV TECO_CONF_FILE PLCComS.ini
ENV TECO_LOG_FILE PLCComS.log

# Set the working directory.
WORKDIR ${TECO_DIR}

# Create directory
RUN mkdir -p ${TECO_DIR}
RUN mkdir -p ${TECO_CONF_DIR}
RUN mkdir -p ${TECO_LOG_DIR}
RUN mkdir -p ${TECO_LIB_DIR}/lib_rpi
RUN mkdir -p ${TECO_LIB_DIR}/lib_rpi2
RUN mkdir -p ${TECO_LIB_DIR}/lib_x86
RUN mkdir -p ${TECO_LIB_DIR}/lib_x86_64

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

# Copy PLCComS configuration
COPY etc/PLCComS.ini ${TECO_CONF_DIR}
COPY etc/FIXED_Foxtrot.pub ${TECO_CONF_DIR}

# Volume configuration
VOLUME ["/var/log/teco", "/opt/teco"]

# Start PLCComS
CMD ["./start.sh"]

# EOF
