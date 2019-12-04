#!/usr/bin/env bash
# run `bash run_docker_analyse_genomes_2019`
set -e
echo "Now pulling the artbio/analyse_genomes:2019 docker image from DockerHub\n"
supervisorctl stop all
docker pull artbio/analyse_genomes:2019
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
          artbio/analyse_genomes:2019`
echo "The analyse_genomes:2019 docker container is deploying...\n"
echo "Press Ctrl-C to interrupt this log and start using the container...\n"
docker logs -f  $DOCKER_INSTANCE
