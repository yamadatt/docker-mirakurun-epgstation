# ベースイメージの指定 (CUDA 12.3 + Ubuntu 22.04)
FROM nvidia/cuda:12.3.1-devel-ubuntu22.04 AS ffmpeg-build

# 環境変数の設定
ENV DEBIAN_FRONTEND=noninteractive
ENV FFMPEG_VERSION=7.1.1

# 必要なパッケージのインストール
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        build-essential \
        autoconf \
        automake \
        cmake \
        git \
        libtool \
        pkg-config \
        yasm \
        nasm \
        libx264-dev \
        libx265-dev \
        libvpx-dev \
        libmp3lame-dev \
        libopus-dev \
        libnuma-dev \
        wget \
        zlib1g-dev && \
    rm -rf /var/lib/apt/lists/*

# NV Codec Headersのインストール (NVENCサポートに必須)
RUN git clone https://git.videolan.org/git/ffmpeg/nv-codec-headers.git && \
    cd nv-codec-headers && \
    make install && \
    cd .. && \
    rm -rf nv-codec-headers

# FFmpegのソースをダウンロードしてビルド
RUN wget -O ffmpeg-${FFMPEG_VERSION}.tar.bz2 https://ffmpeg.org/releases/ffmpeg-${FFMPEG_VERSION}.tar.bz2 && \
    tar xjvf ffmpeg-${FFMPEG_VERSION}.tar.bz2 && \
    cd ffmpeg-${FFMPEG_VERSION} && \
    ./configure \
        --enable-cuda \
        --enable-cuvid \
        --enable-nvenc \
        --enable-nonfree \
        --enable-libnpp \
        --extra-cflags=-I/usr/local/cuda/include \
        --extra-ldflags=-L/usr/local/cuda/lib64 \
        --enable-gpl \
        --enable-libx264 \
        --enable-libx265 \
        --enable-libvpx \
        --enable-libmp3lame \
        --enable-libopus && \
    make -j$(nproc) && \
    make install && \
    cd .. && \
    rm -rf ffmpeg-${FFMPEG_VERSION}*



    # FROM nvidia/cuda:12.3.1-devel-ubuntu22.04

    ENV NODE_VERSION 22
    ENV DEBIAN_FRONTEND=noninteractive
    ENV RUNTIME="libasound2 libass9 libvdpau1 libva-x11-2 libva-drm2 libxcb-shm0 libxcb-xfixes0 libxcb-shape0 libvorbisenc2 libtheora0 libx264-155 libx265-179 libmp3lame0 libopus0 libvpx6 libaribb24-0"
    
    RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
        apt update && \
        apt upgrade -y && \
        apt install -y wget gcc g++ make && \
        wget https://deb.nodesource.com/setup_${NODE_VERSION}.x -O - | bash - && \
        apt -y install nodejs && \
        # apt install -y $RUNTIME && \
        apt purge -y wget gcc g++ make
        
    COPY --from=l3tnun/epgstation:master-debian /app /app/
    COPY --from=l3tnun/epgstation:master-debian /app/client /app/client/
    # COPY --from=ffmpeg-build /usr/local/bin/ffmpeg /usr/local/bin/
    COPY config/ /app/config
    RUN chmod 444 /app/src -R
    
    # dry run
    RUN ffmpeg -codecs 
    
    LABEL maintainer="maleicacid"
    EXPOSE 8888
    WORKDIR /app
    # ENTRYPOINT ["npm"]
    # CMD ["start"]

# エントリーポイントの設定
# ENTRYPOINT ["ffmpeg"]
# CMD ["ffmpeg" , "-hwaccels"]  # デフォルト動作: 利用可能なハードウェアアクセラレーションを表示
