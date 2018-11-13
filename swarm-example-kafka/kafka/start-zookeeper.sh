#!/bin/bash
KAFKA_IMAGE=exampleplatform/kafka:latest

docker service create \
  --name zookeeper \
  --mount type=volume,source=zoo-data,destination=/tmp/zookeeper \
  --publish 2181:2181 \
  --network kafka-net \
  --constraint node.labels.zoo==1 \
  --mode global \
  ${KAFKA_IMAGE} \
/kafka/bin/zookeeper-server-start.sh /kafka/config/zookeeper.properties
