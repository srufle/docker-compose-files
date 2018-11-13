#!/bin/bash
KAFKA_IMAGE=exampleplatform/kafka:latest
KAFKA_BIN="kafka/bin"
ZOO_EXT="zoo1:2181,zoo2:2181,zoo3:2181"
TOPIC="$1"
CONTAINER_NAME="kafka-worker"

echo "Create topic '${TOPIC}'"
docker run  --network test_zoo_net \
            --rm \
            --name  ${CONTAINER_NAME} \
                    ${KAFKA_IMAGE} "${KAFKA_BIN}/kafka-topics.sh" \
            --zookeeper "${ZOO_EXT}" \
            --if-not-exists \
            --create \
            --replication-factor 3 \
            --partitions 6 \
            --topic "${TOPIC}"
