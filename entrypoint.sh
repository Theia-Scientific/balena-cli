#!/bin/bash
set -e

# Switch to Workspace path
if [ -d "${GITHUB_WORKSPACE}" ]; then
  cd "${GITHUB_WORKSPACE}"
fi

# Switch to Application path
if [ -d "${INPUT_APPLICATION_PATH}" ]; then
  cd "${INPUT_APPLICATION_PATH}"
fi

# Error out of no API Token is available
if [[ "${INPUT_BALENA_API_TOKEN}" == "" ]]; then
  echo "Error: Please set the environment variable INPUT_BALENA_API_TOKEN with a Balena API token"
  exit 1
fi

# Use Alternative environment if provided
if [[ "${INPUT_BALENA_URL}" != "" ]]; then
  echo "balenaUrl: '${INPUT_BALENA_URL}'" >~/.balenarc.yml
fi

# Write secrets file if provided
if [[ "${INPUT_BALENA_SECRETS}" != "" ]]; then
  mkdir -p ~/.balena/
  echo "${INPUT_BALENA_SECRETS}" >~/.balena/secrets.json
fi

# Log in to Balena
/app/balena/bin/balena login --token "${INPUT_BALENA_API_TOKEN}"

# Run command
/app/balena/bin/balena $*
