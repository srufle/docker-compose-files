#!/bin/bash

if [ -z "$1" ]; then
    echo "Please pass username that should be put in the docker group"
fi

echo "Add user '$1' to Docker group so they are not prompted for docker commands"
usermod -aG docker $1
