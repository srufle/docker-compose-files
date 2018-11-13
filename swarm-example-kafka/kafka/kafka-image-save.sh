#!/bin/bash
DOCKER_TAR="example-kafka.tar"
QUIET_OUT="/dev/null"
CMD_ROOT="/vagrant"
DOCKER_IMAGE="confluentinc/cp-kafka:3.3.0"
docker pull ${DOCKER_IMAGE} &> ${QUIET_OUT}
docker save --output "${CMD_ROOT}/kafka/${DOCKER_TAR}" ${DOCKER_IMAGE}

DOCKER_TAR="example-zookeeper.tar"
DOCKER_IMAGE="zookeeper:3.4"
docker pull ${DOCKER_IMAGE} &> ${QUIET_OUT}
docker save --output "${CMD_ROOT}/zookeeper/${DOCKER_TAR}" ${DOCKER_IMAGE}
