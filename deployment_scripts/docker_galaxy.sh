 #!/usr/bin/env bash
 set -e
 echo "Now pulling the galaxykickstart docker image from DockerHub\n"
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
echo "The artbio/biologiegenome docker container is up and running\n"
echo "Please wait for ~1 minute and interrupt logging when all services are launched\n"
echo "Ctrl-C to stop logging\n\n"
docker logs -f $DOCKER_INSTANCE
