#!/usr/bin/env bash
set -e
sudo apt-key adv --recv-keys --keyserver hkp://p80.pool.sks-keyservers.net:80 58118E89F3A912897C070ADBF76221572C52609D
sudo add-apt-repository "deb https://apt.dockerproject.org/repo ubuntu-trusty main"
sudo apt-get update -y
sudo apt-get -y install docker-engine
echo "Docker system is installed\n"
echo "Now pulling the galaxykickstart docker image from DockerHub\n"
docker pull artbio/galaxykickstart
echo "Running galaxykickstart docker container\n"
export DOCKER_INSTANCE=`docker run -d -p 80:80 -p 21:21 -p 8800:8800 \
  --privileged=true \
  -e GALAXY_CONFIG_ALLOW_USER_DATASET_PURGE=True \
  -e GALAXY_CONFIG_ALLOW_LIBRARY_PATH_PASTE=True \
  -e GALAXY_CONFIG_ENABLE_USER_DELETION=True \
  -e GALAXY_CONFIG_ENABLE_BETA_WORKFLOW_MODULES=True \
  -v /tmp/:/tmp/ \
  -v /export/:/export \
  artbio/galaxykickstart`
echo "The galaxykickstart docker container is up and running\n"
echo "Please wait for a few secondes and interrupt logging when all services are launched\n"
echo "Ctrl-C to stop logging\n\n"
docker logs -f $DOCKER_INSTANCE