#!/bin/bash

PROXY_DIR=/home/bbakker/tmp/registry-proxy

docker network create k3d || true

docker run --network k3d -d --name registry-proxy --restart=always \
-v $PROXY_DIR/cache:/docker_mirror_cache \
-v $PROXY_DIR/ca:/ca \
-e DISABLE_IPV6=true \
rpardini/docker-registry-proxy:0.6.5