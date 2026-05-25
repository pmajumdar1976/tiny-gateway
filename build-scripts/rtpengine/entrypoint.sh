#!/bin/bash
set -e

#while true; do
#  echo "Looping..."
#  sleep 10
#done

# Detect interface dynamically
INTERFACE=$(ip route get 8.8.8.8 | grep -oP 'dev \K\S+' | head -n1)
echo "Starting rtpengine on interface: ${INTERFACE}"

# Start rtpengine with your confirmed flags
exec /usr/local/bin/rtpengine \
    --interface="${INTERFACE}" \
    --listen-ng=127.0.0.1:22222 \
    --listen-cli=127.0.0.1:9999 \
    --port-min=30000 \
    --port-max=40000 \
    --log-level=6 \
    --foreground
