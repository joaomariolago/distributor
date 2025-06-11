FROM ubuntu:22.04

# Install required tools
RUN apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y \
  bc \
  bison \
  build-essential \
  ca-certificates \
  coccinelle \
  device-tree-compiler \
  dfu-util \
  efitools \
  flex \
  gcc-arm-linux-gnueabi \
  gcc-arm-linux-gnueabihf \
  gdisk \
  git \
  graphviz \
  imagemagick \
  libgnutls28-dev \
  libguestfs-tools \
  libncurses-dev \
  libpython3-dev \
  libsdl2-dev \
  libssl-dev \
  lz4 \
  lzma \
  lzma-alone \
  lzop \
  openssl \
  pkg-config \
  python3 \
  python3-asteval \
  python3-coverage \
  python3-filelock \
  python3-pkg-resources \
  python3-pycryptodome \
  python3-pyelftools \
  python3-pytest \
  python3-pytest-xdist \
  python3-sphinx-rtd-theme \
  python3-sphinxcontrib.apidoc \
  python3-subunit \
  python3-testtools \
  python3-venv \
  swig \
  u-boot-tools \
  uuid-dev \
  && apt-get clean

WORKDIR /build

COPY ./scripts/u-boot-hi3519.sh .
COPY ./patches/u-boot-hi3519.patch .

RUN git clone --depth=1 https://github.com/OpenIPC/u-boot-hi3519v101.git && \
    cd u-boot-hi3519v101 && \
    patch -p1 < /build/u-boot-hi3519.patch && \
    cp /build/u-boot-hi3519.sh . && \
    chmod +x ./u-boot-hi3519.sh

WORKDIR /build/u-boot-hi3519v101

CMD ["./u-boot-hi3519.sh"]
