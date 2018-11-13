#!/bin/bash

# Ref: https://docs.docker.com/engine/installation/linux/docker-ce/ubuntu/#install-using-the-convenience-script

# Change to empty string
QUIET_APT="-qq"
# Change to /dev/stdout if there are issues
QUIET_APT_OUT="/dev/null"

echo "Setup Repository"
apt-get update ${QUIET_APT}
apt-get install ${QUIET_APT} -y apt-transport-https \
                                ca-certificates curl \
                                software-properties-common \
                                > ${QUIET_APT_OUT}
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
apt-key fingerprint 0EBFCD88
add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) \
    stable"

echo "Install docker"
apt-get update ${QUIET_APT}
apt-get install ${QUIET_APT} -y docker-ce > ${QUIET_APT_OUT}
docker --version

dockerComposeVersion="1.22.0"
echo "Install docker-compose ${dockerComposeVersion}"
curl --silent --show-error\
    -L "https://github.com/docker/compose/releases/download/${dockerComposeVersion}/docker-compose-$(uname -s)-$(uname -m)" -o "/usr/local/bin/docker-compose"
chmod +x /usr/local/bin/docker-compose
docker-compose --version

echo "Run test"
QUIET_OUT="/dev/null"
DOCKER_IMAGE="hello-world"
docker pull ${DOCKER_IMAGE} &> ${QUIET_OUT}
docker run --rm ${DOCKER_IMAGE}

exit 0;
