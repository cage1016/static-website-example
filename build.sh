#!/bin/bash

DAEMON=${DAEMON:-"docker"}
IMAGE=${IMAGE:-"ghcr.io/cage1016/nginx-website"}
VERSION=${VERSION:-"latest"}

set -o errexit
set -o nounset

echo ""
echo "Crearing archive"
(
    envsubst >./Dockerfile <./Dockerfile.template
    ${DAEMON} build -t ${IMAGE}:${VERSION} .
    rm -rf ./Dockerfile
)
