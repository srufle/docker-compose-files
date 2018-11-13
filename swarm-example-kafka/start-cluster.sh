#!/bin/bash

CMD_ROOT="/vagrant"
NODES=(tst-dock-00{1..5})
NODES_LEN=${#NODES[@]}
LEADER_NODE="${NODES[0]}"
DELAY=5

echo "*********************"
echo "Starting process"
echo "*********************"
vagrant up

echo "Making scripts executable"
find ./docker -name "*.sh" -exec chmod +x {} \;
find ./kafka -name "*.sh" -exec chmod +x {} \;

echo "Build swarm"
vagrant ssh -c "${CMD_ROOT}/kafka/start-swarm.sh" ${LEADER_NODE}

for (( index=1; index < ${NODES_LEN}; index++ ));
do
  echo "Join '${NODES[index]}' to swarm"
  vagrant ssh -c "${CMD_ROOT}/tmp/join-swarm.sh" "${NODES[index]}"
done

echo "Add second manager node"
vagrant ssh -c "docker node promote tst-dock-002" ${LEADER_NODE}

echo "Start swarm visualizer"
vagrant ssh -c "${CMD_ROOT}/kafka/start-swarm-vis.sh" ${LEADER_NODE}

echo "Installing kafka container on nodes"
vagrant ssh -c "${CMD_ROOT}/kafka/kafka-image-save.sh" tst-dock-001

for (( index=1; index<${NODES_LEN}; index++ ));
do
  echo "Load kafka image on '${NODES[index]}'"
  vagrant ssh -c "${CMD_ROOT}/kafka/kafka-image-load.sh" "${NODES[index]}"
done

echo "Start zookeeper"
vagrant ssh -c "${CMD_ROOT}/zookeeper/start-zookeeper.sh" ${LEADER_NODE}
echo "Wait to make sure zookeeper is up"
sleep $DELAY

echo "Start kafka nodes"
vagrant ssh -c "${CMD_ROOT}/kafka/start-kafka.sh" ${LEADER_NODE}

echo "Wait to make sure kafka is up"
sleep $DELAY
vagrant ssh -c "${CMD_ROOT}/kafka/test-topic-lifecycle.sh example-topic" tst-dock-002
