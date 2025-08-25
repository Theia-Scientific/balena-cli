FROM debian:stable-slim
LABEL Description="Use the Balena CLI to perform actions"

## Build arguments

## CLI version
ARG CLI_VERSION=22.2.4
ARG CLI_URL=https://github.com/balena-io/balena-cli/releases/download/v${CLI_VERSION}
ARG CLI_ARCHIVE=balena-cli-v${CLI_VERSION}-linux-x64-standalone.tar.gz
ARG DEBIAN_FRONTEND=noninteractive

WORKDIR /app

## Install the standalone balena-cli package
RUN apt update && \
    apt install -y \
        curl && \
    apt autoremove -y && \
    rm -rf /var/lib/apt/lists/* && \
    apt clean

## Download and Unzip Balena CLI
RUN curl -O -sSL ${CLI_URL}/${CLI_ARCHIVE} && \
    tar -xvzf balena-cli-${CLI_ARCHIVE}-linux-x64-standalone.tar.gz

## Copy Entrypoint
COPY entrypoint.sh ./entrypoint.sh

## Entrypoint
ENTRYPOINT ["/app/entrypoint.sh"]
