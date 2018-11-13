#!/bin/bash
QUIET_OUT="/dev/null"
DOCKER_IMAGE="dockersamples/visualizer"
docker pull ${DOCKER_IMAGE} &> ${QUIET_OUT}
docker run -it -d -p 8082:8080 \
            -v /var/run/docker.sock:/var/run/docker.sock \
            ${DOCKER_IMAGE}