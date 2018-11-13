#!/bin/bash
KAFKA_IMAGE=exampleplatform/kafka:latest
KAFKA_BIN="kafka/bin"
ZOO_EXT="zoo1:2181,zoo2:2181,zoo3:2181"
TOPIC="$1"
CONTAINER_NAME="kafka-worker"
docker run --network test_zoo_net --rm --name ${CONTAINER_NAME} ${KAFKA_IMAGE} "${KAFKA_BIN}/kafka-topics.sh" \
           --list --topic "${TOPIC}" --zookeeper "${ZOO_EXT}"

echo "Done listing"
