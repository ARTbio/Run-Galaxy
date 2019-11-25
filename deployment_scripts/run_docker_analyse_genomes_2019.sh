#!/usr/bin/env sh
# run `sh run_docker_analyse_genomes_2019 artbio/analyse_genomes:2019`
set -e
echo "Now pulling the artbio/analyse_genomes:2019 docker image from DockerHub\n"
# supervisorctl stop all
docker pull $1
echo "Running artbio/analyse_genomes:2019 docker container\n"
mkdir /galaxy_export /galaxy_tmp && chown 1450:1450 /galaxy_export /galaxy_tmp
export DOCKER_INSTANCE=`docker run -d -p 80:80 -p 21:21 -p 8800:8800 \
          --privileged=true \
          -e GALAXY_CONFIG_ALLOW_USER_DATASET_PURGE=True \
          -e GALAXY_CONFIG_ALLOW_LIBRARY_PATH_PASTE=True \
          -e GALAXY_CONFIG_ENABLE_USER_DELETION=True \
          -e GALAXY_CONFIG_ENABLE_BETA_WORKFLOW_MODULES=True \
          -v /galaxy_tmp:/tmp \
          -v /galaxy_export:/export \
          $1`
echo "The $1 docker container is deploying...\n"
sleep 120
echo "The $1 docker container is up and running\n"
docker logs  $DOCKER_INSTANCE
docker exec $DOCKER_INSTANCE sudo supervisorctl restart galaxy:
