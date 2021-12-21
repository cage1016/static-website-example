#!/bin/bash
#
# Run JMeter Docker image with options

NAME="jmeter"
# JMETER_VERSION=${JMETER_VERSION:-"latest"}
# IMAGE="justb4/jmeter:${JMETER_VERSION}"
IMAGE="docker.io/apachejmeter-s390x:5.1.1"

# Finally run
docker run --rm --name ${NAME} --network host -i -v ${PWD}:${PWD} -w ${PWD} ${IMAGE} $@
