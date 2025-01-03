#!/bin/sh

RETRY_COUNT=0
WAIT_TIME=5

while true; do
    echo "=== Start FFmpeg ==="

    ffmpeg -rw_timeout $((WAIT_TIME * 1000000)) \
        -i rtmp://$NGINX_HOST/live1 \
        -c:v libx264 -preset veryfast -s 1280x720 -b:v 5000k -maxrate 5000k -bufsize 5000k \
        -c:a aac -b:a 128k -f flv \
        rtmp://xliveorigin.dmc.nico/named_input/$NICONICO_STREAM_KEY

    if [ $? -eq 0 ]; then
        echo "=== Completed FFmpeg ==="
        exit 0
    fi
    sleep $WAIT_TIME
    RETRY_COUNT=$((RETRY_COUNT + 1))
    echo "=== Retry FFmpeg $RETRY_COUNT ==="
done
echo "=== Failed FFmpeg ==="
