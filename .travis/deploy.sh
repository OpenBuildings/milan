#!/usr/bin/env bash

set -e

openssl aes-256-cbc -K $encrypted_c5c534c0fd9c_key -iv $encrypted_c5c534c0fd9c_iv -in ./id_rsa.enc -out ./id_rsa -d

for i in {1..2}; do
    SERVER_IP_VAR_NAME=SERVER${i}_IP
    IP=${!SERVER_VAR_NAME}
    echo "Deploying to $IP..."
    ssh -i ./id_rsa -t clippings@$IP "cd $DEPLOY_DIR && git fetch --depth=5 && git reset --hard $TRAVIS_TAG"
done
