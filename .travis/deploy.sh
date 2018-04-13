#!/usr/bin/env bash

set -e

openssl aes-256-cbc -K $encrypted_c5c534c0fd9c_key -iv $encrypted_c5c534c0fd9c_iv -in .travis/id_rsa.enc -out .travis/id_rsa -d

echo $SERVER1_PUBLIC_KEY >> $HOME/.ssh/known_hosts
echo $SERVER2_PUBLIC_KEY >> $HOME/.ssh/known_hosts

ssh -i .travis/id_rsa -t clippings@$SERVER1_IP "cd $DEPLOY_DIR && git fetch --depth=5 && git reset --hard $TRAVIS_TAG"
ssh -i .travis/id_rsa -t clippings@$SERVER2_IP "cd $DEPLOY_DIR && git fetch --depth=5 && git reset --hard $TRAVIS_TAG"
