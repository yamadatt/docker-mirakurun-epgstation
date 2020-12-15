FROM chinachu/mirakurun:3.3.1
RUN set -ex && \
    apt update && \
    apt install -y --no-install-recommends \
    git \
    make \
    gcc \
    automake \
    && \
    GIT_SSL_NO_VERIFY=1 git clone https://github.com/stz2012/recpt1 /tmp/recpt1 && \
    cd /tmp/recpt1/recpt1 && \
    ./autogen.sh && \
    ./configure && \
    make && \
    make install && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*