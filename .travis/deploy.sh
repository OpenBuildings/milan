#!/usr/bin/env bash

set -e

for i in {1..2}; do
    SERVER_IP_VAR_NAME=SERVER${i}_IP
    IP=${!SERVER_VAR_NAME}
    ssh -t clippings@$IP -i id_rsa "cd $DEPLOY_DIR && git fetch --depth=5 && git reset --hard $TRAVIS_TAG"
done
