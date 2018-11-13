#!/bin/bash
CMD_ROOT="/vagrant"
TOPIC="$1"
DELAY=5

${CMD_ROOT}/kafka/topic-create.sh "${TOPIC}"
sleep $DELAY
${CMD_ROOT}/kafka/topic-produce.sh "${TOPIC}"
sleep $DELAY
${CMD_ROOT}/kafka/topic-consume.sh "${TOPIC}"

