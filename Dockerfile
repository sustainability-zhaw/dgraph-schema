FROM ubuntu:22.04

LABEL maintainer="phish108 <cpglahn@gmail.com>"
LABEL org.opencontainers.image.source="https://github.com/sustainability-zhaw/dgraph-schema"

RUN useradd -m -d /data automator && \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive \
    apt-get install -y --no-install-recommends \
    curl \
    # git \
    # jq \
    # libjson-pp-perl \
    # iputils-ping \
    # vim \
    && \
    apt-get clean

WORKDIR /data 

COPY schema /data/schema
COPY entrypoint.sh /data

RUN chmod 500 /data/entrypoint.sh && \
    chown -R automator /data

USER automator

ENTRYPOINT [ "/data/entrypoint.sh" ]
