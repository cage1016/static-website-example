#!/bin/bash

NAME="jmeter"
JMETER=${JMETER:-"docker.io/kaichu1016/jmeter"}
JMETER_VERSION=${JMETER_VERSION:-"latest"}
IMAGE="${JMETER}:${JMETER_VERSION}"

T_DIR=./tests

# Reporting dir: start fresh
R_DIR=${T_DIR}/report
rm -rf ${R_DIR} > /dev/null 2>&1
mkdir -p ${R_DIR}

/bin/rm -f ${T_DIR}/stresstest.jtl ${T_DIR}/jmeter.log  > /dev/null 2>&1

podman run --rm --name ${NAME} --network host -i -v ${PWD}:${PWD} -w ${PWD} ${IMAGE} \
	${T_DIR}/stresstest.jmx -l ${T_DIR}/stresstest.jtl -j ${T_DIR}/jmeter.log \
	-JTARGET_HOST=${TARGET_HOST} \
	-JTARGET_PORT=${TARGET_PORT} \
	-JTARGET_PATH=${TARGET_PATH} \
	-JTHREADS=${THREADS} \
	-JRAMD_UP=${RAMD_UP} \
	-JDURATION=${DURATION} \
	-JSETUP_DELAY=${SETUP_DELAY} \
	-o ${R_DIR} -e

echo "==== jmeter.log ===="
echo "See jmeter log in ${T_DIR}/jmeter.log"

echo "==== Raw Test Report ===="
echo "See Raw test report in ${T_DIR}/stresstest.jtl"

echo "==== HTML Test Report ===="
echo "See HTML test report in ${R_DIR}/index.html"
