#!/usr/bin/env sh
set -e
echo "Now pulling the galaxykickstart docker image from DockerHub\n"
supervisorctl stop all
docker pull artbio/biologiegenome
echo "Running galaxykickstart docker container\n"
export DOCKER_INSTANCE=`docker run -d -p 80:80 -p 21:21 -p 8800:8800 \
          --privileged=true \
          -e GALAXY_CONFIG_ALLOW_USER_DATASET_PURGE=True \
          -e GALAXY_CONFIG_ALLOW_LIBRARY_PATH_PASTE=True \
          -e GALAXY_CONFIG_ENABLE_USER_DELETION=True \
          -e GALAXY_CONFIG_ENABLE_BETA_WORKFLOW_MODULES=True \
          -v /tmp/:/tmp/ \
          -v /export/:/export \
          artbio/biologiegenome`
echo "The artbio/biologiegenome docker container is deploying...\n"
sleep 90
echo "The artbio/biologiegenome docker container is up and running\n"
docker logs  $DOCKER_INSTANCE
docker exec $DOCKER_INSTANCE sudo su galaxy -c '/home/galaxy/galaxy/.venv/bin/pip install cryptography==2.2.2'
