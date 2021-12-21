#!/bin/bash
#
# Run JMeter Docker image with options

NAME="jmeter"
JMETER=${JMETER:-"justb4/jmeter"}
JMETER_VERSION=${JMETER_VERSION:-"latest"}
IMAGE="${JMETER}:${JMETER_VERSION}"

# Finally run
podman run --rm --name ${NAME} --network host -i -v ${PWD}:${PWD} -w ${PWD} ${IMAGE} $@