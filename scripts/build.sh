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

function build {
  echo "BUILD ..."
  rm -r ${BUILD_DIR} >/dev/null 2>&1

  mkdir .build
  go build -o ${BUILD_DIR}/main .
  cp .base.env ${BUILD_DIR}/
  cp config.yaml ${BUILD_DIR}/

  cd $RUNNING_DIR
}

function main() {
  build
}

if [ "${1}" != "--source-only" ]; then
  main "${@}"
fi
