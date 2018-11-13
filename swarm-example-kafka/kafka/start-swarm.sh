#!/bin/bash
INTERFACE="eth1"
ADVERTISE_ADDR=$(ip addr show ${INTERFACE} | grep -Po 'inet \K[\d.]+')
docker swarm init --advertise-addr "${ADVERTISE_ADDR}"

CMD_ROOT="/vagrant"
JOIN_CMD=$(docker swarm join-token worker | grep token)
echo "#!/bin/bash" > "${CMD_ROOT}/tmp/join-swarm.sh"
echo "${JOIN_CMD}" >> "${CMD_ROOT}/tmp/join-swarm.sh"
chmod +x "${CMD_ROOT}/tmp/join-swarm.sh"