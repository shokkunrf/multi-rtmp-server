FROM nginx:1.26.2-alpine3.20-slim AS builder

RUN apk add --no-cache \
    alpine-sdk \
    curl \
    pcre-dev \
    zlib-dev \
    openssl-dev

WORKDIR /usr/local/src
RUN curl -o nginx-1.26.2.tar.gz http://nginx.org/download/nginx-1.26.2.tar.gz && \
    tar -xvzf nginx-1.26.2.tar.gz && \
    curl -o nginx-rtmp-module-1.2.2.tar.gz -L https://github.com/arut/nginx-rtmp-module/archive/refs/tags/v1.2.2.tar.gz && \
    tar -xvzf nginx-rtmp-module-1.2.2.tar.gz

WORKDIR /usr/local/src/nginx-1.26.2
RUN ./configure --with-compat --add-dynamic-module=/usr/local/src/nginx-rtmp-module-1.2.2 && \
    make modules

FROM nginx:1.26.2-alpine3.20-slim

RUN apk add --no-cache \
    ffmpeg

COPY --from=builder /usr/local/src/nginx-1.26.2/objs/ngx_rtmp_module.so /usr/lib/nginx/modules/ngx_rtmp_module.so
COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 1935
