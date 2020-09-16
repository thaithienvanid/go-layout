#!/bin/bash

if [[ ${DEBUG-} =~ ^1|yes|true$ ]]; then
  set -o xtrace
fi

RUNNING_DIR="$(pwd -P)"
SCRIPT_DIR="$(
  cd "$(dirname "$0")"
  pwd -P
)"
ROOT_DIR="$(dirname $SCRIPT_DIR)"

BUILD_DIR=${ROOT_DIR}/.build

function envup {
  echo "ENVUP ..."
  set -o allexport
    source ${BUILD_DIR}/.base.env
  set +o allexport
}

function start {
  echo "START ..."

  ${BUILD_DIR}/main --config=${BUILD_DIR}/config.yaml
}

source ${SCRIPT_DIR}/build.sh --source-only

function main() {
  build
  envup
  start
}

if [ "${1}" != "--source-only" ]; then
  main "${@}"
fi
