#!/bin/bash
KAFKA_IMAGE=exampleplatform/kafka:latest
KAFKA_BIN="kafka/bin"
BROKER_EXT="kafka1:19092,kafka2:19092,kafka3:19092,kafka4:19092,kafka5:19092"
TOPIC="$1"
CONTAINER_NAME="kafka-worker"

echo "Start consuming messages on '${TOPIC}'"
docker run  --network test_zoo_net \
            --rm --name ${CONTAINER_NAME} ${KAFKA_IMAGE} \
            "${KAFKA_BIN}/kafka-console-consumer.sh" \
            --bootstrap-server "${BROKER_EXT}" \
            --topic "${TOPIC}" --from-beginning --max-messages 42

echo "Finished consuming messages on '${TOPIC}'"

