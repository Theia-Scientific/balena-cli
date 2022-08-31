FROM debian:stable-slim
LABEL Description="Use the Balena CLI to perform actions"

## Install the standalone balena-cli package
RUN apt-get update && apt-get install -y curl unzip

WORKDIR  /app

## Download and Unzip Balena CLI
RUN curl -O -sSL https://github.com/balena-io/balena-cli/releases/download/v14.3.0/balena-cli-v14.3.0-linux-x64-standalone.zip && \ 
  unzip balena-cli-*-linux-x64-standalone.zip

## Copy Entrypoint
COPY entrypoint.sh ./entrypoint.sh

## Entrypoint
ENTRYPOINT ["/app/entrypoint.sh"]
