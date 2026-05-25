# Use a build stage to keep the final image slim
FROM debian:bookworm-slim AS builder

RUN apt update && apt install -y --no-install-recommends \
    git \
    ca-certificates \
    build-essential \
    dpkg-dev \
    debhelper \
    pkg-config \
    gperf \
    libglib2.0-dev \
    libjson-glib-dev \
    libpcap-dev \
    libssl-dev \
    libcurl4-openssl-dev \
    libjansson-dev \
    libxml2-dev \
    libhiredis-dev \
    libevent-dev \
    libspandsp-dev \
    libiptc-dev \
    libavcodec-dev \
    libavformat-dev \
    libavutil-dev \
    libavfilter-dev \
    libswresample-dev \
    libswscale-dev \
    libwebsockets-dev \
    libncursesw5-dev \
    libpcre2-dev \
    libopus-dev \
    libjwt-dev \
    default-libmysqlclient-dev \
    pandoc \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /src
RUN git clone --depth 1 https://github.com/sipwise/rtpengine.git
WORKDIR /src/rtpengine/daemon
RUN make clean all no_docs=1 with_iptables_option=no

# Final runtime image
FROM debian:bookworm-slim
RUN apt update && apt install -y --no-install-recommends \
    libglib2.0-0 \
    libjson-glib-1.0-0 \
    libpcap0.8 \
    libssl3 \
    libcurl4 \
    libjansson4 \
    libxml2 \
    libhiredis0.14 \
    libevent-2.1-7 \
    libevent-pthreads-2.1-7 \
    libevent-2.1-7 \
    libspandsp2 \
    libavcodec59 \
    libavformat59 \
    libavutil57 \
    libavfilter8 \
    libswresample4 \
    libswscale6 \
    libwebsockets17 \
    libpcre2-8-0 \
    libopus0 \
    libjwt0 \
    libmariadb3 \
    libip4tc2 \
    libip6tc2 \
    iproute2 \
    && rm -rf /var/lib/apt/lists/*
#RUN apt update && apt install -y --no-install-recommends \
#    && rm -rf /var/lib/apt/lists/*

COPY --from=builder /src/rtpengine/daemon/rtpengine /usr/local/bin/rtpengine

# Create necessary directories
RUN mkdir -p /rec && chmod 777 /rec

# Use an entrypoint script to handle dynamic interface detection
COPY rtpengine.sh /rtpengine.sh
RUN chmod +x /rtpengine.sh
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
