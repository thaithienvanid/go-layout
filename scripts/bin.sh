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

function code_format() {
  gofmt -w ${ROOT_DIR}/cmd/ ${ROOT_DIR}/internal/ ${ROOT_DIR}/libraries/
  goimports -w ${ROOT_DIR}/cmd/ ${ROOT_DIR}/internal/ ${ROOT_DIR}/libraries/
}

function main() {
  case $1 in
    code_format)
      code_format
      ;;
    *)
      echo "./scripts/bin.sh [code_format]"
      ;;
  esac
}

if [ "${1}" != "--source-only" ]; then
  main "${@}"
fi
