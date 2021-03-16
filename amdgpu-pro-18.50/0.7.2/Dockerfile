FROM wesparish/amdgpu-pro-18.50-708488-ubuntu18.04

USER root

RUN apt-get update \
 && apt-get install -y \
	vim-tiny \
	jq \
	flip \
        ca-certificates \
        iputils-ping \
        libssl-dev \
        curl \
 && apt-get -y clean \
 && rm -rf /var/lib/apt/lists/*

WORKDIR /home/miner

ENV MINER_URL="https://github.com/CryptoGraphics/VerthashMiner/releases/download/0.7.2/VerthashMiner-0.7.2-CUDA11-linux.tar.gz"
RUN curl -Lso miner.tar.gz ${MINER_URL} && \
    tar -xzf miner.tar.gz && \
    mv *iner*-*-linux/* . && \
    rmdir *iner*-*-linux && \
    rm miner.tar.gz

COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

# ./teamredminer -a ethash -o stratum+tcp://us1.ethermine.org:4444 -u 0x331077Cd09209dc9e51c2E44a711f928dE3F669e.$HOSTNAME -p xxxx
ENV WALLET_ADDRESS="3NRZzUYhoFyA9aL7edLA9D4SwcNfAwhhNf" \
    POOL="stratum+tcp://mining.hashalot.net:3950" \
    HOSTNAME="docker" \
    EXTRA_OPTS="" \
    PASSWORD= \
    ETH_4G_MAX_ALLOC= \
    DAT_URL="https://nexus-jamie.elastiscale.net/repository/mining-repo/verthashminer/verthash.dat"

RUN chown -R root:root /home/miner/

# Add Tini
ENV TINI_VERSION v0.18.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini
ENTRYPOINT ["/tini", "--"]

CMD ["/usr/local/bin/docker-entrypoint.sh"]
