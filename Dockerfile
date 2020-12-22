# HMCFGUSB
# http://git.zerfleddert.de/cgi-bin/gitweb.cgi/hmcfgusb
FROM alpine:3.12

# Package version
ARG HMCFGUSB_VER=0.103

# Install build packages
RUN apk add --no-cache --virtual=build-dependencies \
            build-base \
            libusb-dev \
# Install runtime packages
 && apk add --no-cache \
            libusb \
# Install app
 && wget http://git.zerfleddert.de/hmcfgusb/releases/hmcfgusb-$HMCFGUSB_VER.tar.gz -P /tmp \
 && mkdir /app \
 && tar -xzf /tmp/hmcfgusb-$HMCFGUSB_VER.tar.gz -C /app \
 && ln -s /app/hmcfgusb-$HMCFGUSB_VER /app/hmcfgusb \
 && cd /app/hmcfgusb-$HMCFGUSB_VER \
 && make \
# Cleanup
 && apk del --purge build-dependencies \
 && rm *.h *.o *.c *.d \
 && rm /tmp/hmcfgusb-$HMCFGUSB_VER.tar.gz
 
WORKDIR /app/hmcfgusb

EXPOSE 1234

CMD ["/app/hmcfgusb/hmland", "-v", "-p 1234", "-I"]
