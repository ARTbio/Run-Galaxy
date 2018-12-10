#!/usr/bin/env sh
set -e
echo "Now pulling the galaxykickstart docker image from DockerHub\n"
supervisorctl stop all
docker pull $1
echo "Running galaxykickstart docker container\n"
export DOCKER_INSTANCE=`docker run -d -p 80:80 -p 21:21 -p 8800:8800 \
          --privileged=true \
          -e GALAXY_CONFIG_ALLOW_USER_DATASET_PURGE=True \
          -e GALAXY_CONFIG_ALLOW_LIBRARY_PATH_PASTE=True \
          -e GALAXY_CONFIG_ENABLE_USER_DELETION=True \
          -e GALAXY_CONFIG_ENABLE_BETA_WORKFLOW_MODULES=True \
          -v /tmp/:/tmp/ \
          -v /export/:/export \
          $1`
echo "The $1 docker container is deploying...\n"
sleep 90
echo "The $1 docker container is up and running\n"
docker logs  $DOCKER_INSTANCE
docker exec $DOCKER_INSTANCE sudo su galaxy -c '/home/galaxy/galaxy/.venv/bin/pip install cryptography==2.2.2'
docker exec $DOCKER_INSTANCE sudo su galaxy -c 'cd ~/galaxy/config && wget https://raw.githubusercontent.com/ARTbio/Run-Galaxy/master/deployment_scripts/sanitize_whitelist.txt'
echo "Galaxy in container will restart to take into account new settings\n"
sleep 120
docker exec $DOCKER_INSTANCE sudo supervisorctl restart galaxy:
