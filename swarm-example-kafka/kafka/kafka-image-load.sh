#!/bin/bash
DOCKER_TAR="example-kafka.tar"
QUIET_OUT="/dev/null"
CMD_ROOT="/vagrant"
docker load --input "${CMD_ROOT}/kafka/${DOCKER_TAR}" &> ${QUIET_OUT}

DOCKER_TAR="example-zookeeper.tar"
DOCKER_IMAGE="zookeeper:3.4"
docker pull ${DOCKER_IMAGE} &> ${QUIET_OUT}
docker load --input "${CMD_ROOT}/zookeeper/${DOCKER_TAR}" &> ${QUIET_OUT}
