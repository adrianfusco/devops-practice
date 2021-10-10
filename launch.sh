#!/bin/bash

#

# _________________________________________________ #

networkName="ansibleTestNetwork"

#############
# FUNCTIONS #
#############

function removeDockers() {
  for x in {2..10}; do 
    echo "Trying to remove client$x";
    docker rm --force "client$x" >/dev/null 2>&1;
    docker-compose down
  done
}

function createKeys() {
  yes | ssh-keygen -t rsa -b 4096 -f ./files/keys/id_rsa_docker_test
}

function createNetwork() {
  # Check if networks exists and if not create it
  docker network inspect ${networkName} >/dev/null 2>&1 || \
      docker network create --subnet=10.20.10.0/24 --driver bridge ${networkName} || \
      { echo "Details: Error creating network ${networkName}."; exit 1; }
}

function buildAndCreateManagedNodes() {
  netWithoutHostSide=10.20.10.
  docker build -f files/dockerFiles/DockerfileManagedNode -t managedansiblenode .
  for i in {2..10}
  do
    docker run --network ${networkName} --ip "${netWithoutHostSide}${i}"  -t -d --name "client${i}" managedansiblenode:latest 
  done
}

function buildAndCreateControlNode() {
  docker-compose up -d --force-recreate --build
}

# _________________________________________________ #


if [[ "$1" == "remove" ]]; then
  removeDockers
  { echo "Finished."; exit 0; }
fi

createKeys
createNetwork
buildAndCreateControlNode
buildAndCreateManagedNodes
{ echo "Finished."; exit 0; }