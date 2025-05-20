#!/bin/bash

context=$(kubectl config current-context)
cluster_name=$(echo $context | cut -d- -f2-)

container_id=$(docker ps | grep "k3d-${cluster_name}-server-0" | cut -d\  -f1)
ip_address=$(docker inspect $container_id | jq -r '.[].NetworkSettings.Networks.k3d.IPAddress')

config=${1:-onprem}
remote=upstream
repo=${2:-$(git remote get-url origin)}
# hardcode for now until I switch from ssh to https git remote
repo=https://github.com/bastiaanb/kuberise.io.git
revision=${3:-$(git branch --show-current)}
echo scripts/install.sh $context $config $repo $revision ${ip_address}.nip.io 
time scripts/install.sh $context $config $repo $revision ${ip_address}.nip.io 