#!/bin/bash
#
# Test the JMeter Docker image using a trivial test plan.

# Example for using User Defined Variables with JMeter
# These will be substituted in JMX test script
# See also: http://stackoverflow.com/questions/14317715/jmeter-changing-user-defined-variables-from-command-line
export TARGET_HOST="localhost"
export TARGET_PORT="8080"
export TARGET_PATH="/"
export THREADS="20"
export RAMD_UP="40"
export DURATION="60"
export SETUP_DELAY="5"

T_DIR=tests

# Reporting dir: start fresh
R_DIR=${T_DIR}/report
rm -rf ${R_DIR} > /dev/null 2>&1
mkdir -p ${R_DIR}

/bin/rm -f ${T_DIR}/stresstest.jtl ${T_DIR}/jmeter.log  > /dev/null 2>&1

./run.sh -Dlog_level.jmeter=DEBUG \
	-JTARGET_HOST=${TARGET_HOST} \
	-JTARGET_PORT=${TARGET_PORT} \
	-JTARGET_PATH=${TARGET_PATH} \
	-JTHREADS=${THREADS} \
	-JRAMD_UP=${RAMD_UP} \
	-JDURATION=${DURATION} \
	-JSETUP_DELAY=${SETUP_DELAY} \
	${T_DIR}/stresstest.jmx -l ${T_DIR}/stresstest.jtl -j ${T_DIR}/jmeter.log \
	-e -o ${R_DIR}

echo "==== jmeter.log ===="
cat ${T_DIR}/jmeter.log

echo "==== Raw Test Report ===="
cat ${T_DIR}/stresstest.jtl

echo "==== HTML Test Report ===="
echo "See HTML test report in ${R_DIR}/index.html"
