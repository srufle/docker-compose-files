#!/bin/bash
KAFKA_IMAGE=exampleplatform/kafka:latest
KAFKA_BIN="kafka/bin"
BROKER_EXT="kafka1:19092,kafka2:19092,kafka3:19092,kafka4:19092,kafka5:19092"
TOPIC="$1"
CONTAINER_NAME="kafka-worker"

echo "Start producing messages on '${TOPIC}'"
docker run  --network test_zoo_net \
            --rm \
            --name ${CONTAINER_NAME} ${KAFKA_IMAGE} bash -c \
    "seq 42 | ${KAFKA_BIN}/kafka-console-producer.sh --request-required-acks 1 --broker-list ${BROKER_EXT} --topic ${TOPIC} && echo 'Produced 42 messages.'"

echo "Finished producing messages on '${TOPIC}'"
