#!/bin/bash
PROVISION_DIR="/vagrant"
DOCKER_DIR="${PROVISION_DIR}/docker"
COMPOSE_FILES_DIR="${PROVISION_DIR}/kafka"

COMPOSE_YAML="${COMPOSE_FILES_DIR}/kafka-compose.yml"
if [ -e "${COMPOSE_YAML}" ]; then
    #docker-compose -f "${COMPOSE_YAML}" up -d
    docker stack deploy --compose-file "${COMPOSE_YAML}" "test"
else
    echo "'${COMPOSE_YAML}' was not found"
fi