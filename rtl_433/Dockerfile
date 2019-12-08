ARG BUILD_FROM
FROM $BUILD_FROM

ENV LANG C.UTF-8

RUN apk add --no-cache libusb && \
    apk add --no-cache --virtual build-deps \
            alpine-sdk cmake git libusb-dev && \
    mkdir /tmp/build && cd /tmp/build && \
    \
    git clone git://git.osmocom.org/rtl-sdr.git && \
    cd rtl-sdr && mkdir build && cd build && \
    cmake .. -DINSTALL_UDEV_RULES=ON -DDETACH_KERNEL_DRIVER=ON -DCMAKE_INSTALL_PREFIX:PATH=/usr/local &&  \
    make && make install && \
    chmod +s /usr/local/bin/rtl_* && \
    \
    cd /tmp/build && \
    git clone https://github.com/merbanan/rtl_433 && \
    cd rtl_433 && mkdir build && cd build && \
    cmake .. && \
    make && make install && \
    \
    apk del build-deps && rm -rf /tmp/build

COPY run.sh /
RUN chmod a+x /run.sh
CMD [ "/run.sh" ]

