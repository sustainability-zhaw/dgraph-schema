# Create runtime (public) container
FROM ubuntu:22.04

LABEL maintainer="phish108 <cpglahn@gmail.com>"
LABEL org.opencontainers.image.source="https://github.com/sustainability-zhaw/dgraph-schema"

COPY schema /data
COPY entrypoint.sh /data

RUN adduser -S automator && \
    mkdir -p /data && \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive \
    apt-get install -y --no-install-recommends \
    curl \
    git \
    jq \
    json_pp \
    && \
    apt-get clean

WORKDIR /data 

RUN chmod 500 /data/entrypoint.sh && \
    chown -R automator /data

USER automator

ENTRYPOINT [ "/data/entrypoint.sh" ]
