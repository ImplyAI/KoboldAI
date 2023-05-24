FROM debian:10

EXPOSE 5000/tcp

ENV \
    # https://github.com/mamba-org/boa-forge/releases
    MICROMAMBA_VERSION=1.0.0

RUN apt-get update && \
    apt-get install --yes --no-install-recommends \
        wget \
        aria2 \
        git \
        bzip2 \
        ca-certificates \
    && \
    # Cleaning up:
    apt-get purge --yes --auto-remove -o APT::AutoRemove::RecommendsImportant=false && \
    rm -rf /var/lib/apt/lists/*

RUN \
    # Downloading cloudflared-linux-amd64 because Cloudflare once failed to upload the latest version yet the package
    # manifest was there:
    wget \
      --no-check-certificate \
      https://github.com/cloudflare/cloudflared/releases/download/2023.5.0/cloudflared-linux-amd64 \
      --directory-prefix /tmp && \
    chmod +x /tmp/cloudflared-linux-amd64

WORKDIR /opt/koboldai

RUN \
    # https://mamba.readthedocs.io/en/latest/installation.html#linux-and-macos
    wget \
      --no-check-certificate \
      --compression=none \
      -O- https://micromamba.snakepit.net/api/micromamba/linux-64/${MICROMAMBA_VERSION} | \
        tar -xvj bin/micromamba

COPY ./install_requirements.sh ./
COPY ./environments/ ./environments/
RUN chmod +x ./install_requirements.sh && \
    ./install_requirements.sh cuda

COPY ./docker-standalone/docker-helper.sh ./docker-standalone/
RUN chmod +x ./docker-standalone/docker-helper.sh

CMD /opt/koboldai/docker-helper.sh

COPY . ./
