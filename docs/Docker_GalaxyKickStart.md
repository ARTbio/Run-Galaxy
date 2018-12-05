## Installation of a Galaxy server with Docker

### What is Docker ?

![Docker](images/docker.png)

#### Virtual machines

Virtual machines (VMs) are an abstraction of physical hardware turning one server into
many servers. The hypervisor allows multiple VMs to run on a single machine.
Each VM includes a full copy of an operating system, one or more apps, necessary binaries
and libraries - taking up tens of GBs. VMs can also be slow to boot.

#### Containers

Containers are an abstraction at the app layer that packages code and dependencies
together. Multiple containers can run on the same machine and share the OS kernel with
other containers, each running as isolated processes in user space. Containers take up
less space than VMs (container images are typically tens of MBs in size), and start
almost instantly.

###  GalaxyKickStart Docker **Container**

Instead of using the GalaxyKickStart playbook in a VM, the playbook can be used to build
a Docker container image that will be an almost exact mirror of the GalaxyKickStart VM
you have just built.

You are not going to do that today (although you should be able to do it by reading the instructions).

Instead, you are going to

- Install the `docker` system
- pull the GalaxyKickStart docker container that is deposited in the [`Docker Hub`](https://hub.docker.com/u/artbio/)
- run this docker container and connect to the deployed GalaxyKickStart server instance

### Deployment

- There is actually no need for a new VM, the ansible already installed the docker service
in the VM used to deploy GalaxyKickStart.
- If not already, be connected to you VM as root user using the Google ssh console (`sudo -i`)
- download the script `docker_galaxy.sh` using the command `wget https://raw.githubusercontent.com/ARTbio/Run-Galaxy/master/deployment_scripts/docker_galaxy.sh`
- run the script using the command `sh docker_galaxy.sh`
- Connect to your docker-deployed "GalaxyKickStart" instance:
    
    Just click on the url displayed in your Google Cloud Engine Console
    and connect using the login:password `admin@galaxy.org:admin`
    
    
#### The docker_galaxy.sh script explained

NB: in the following code, numbers in line heads should be removed to run the script.

```
1  #!/usr/bin/env bash
2  set -e
3  echo "Now pulling the galaxykickstart docker image from DockerHub\n"
4  docker pull artbio/biologiegenome
5 echo "Running galaxykickstart docker container\n"
6 export DOCKER_INSTANCE=`docker run -d -p 80:80 -p 21:21 -p 8800:8800 \
7           --privileged=true \
8           -e GALAXY_CONFIG_ALLOW_USER_DATASET_PURGE=True \
9           -e GALAXY_CONFIG_ALLOW_LIBRARY_PATH_PASTE=True \
10           -e GALAXY_CONFIG_ENABLE_USER_DELETION=True \
11           -e GALAXY_CONFIG_ENABLE_BETA_WORKFLOW_MODULES=True \
12           -v /tmp/:/tmp/ \
13           -v /export/:/export \
14           artbio/biologiegenome`
15 echo "The artbio/biologiegenome docker container is up and running\n"
16 echo "Please wait for ~1 minute and interrupt logging when all services are launched\n"
17 echo "Ctrl-C to stop logging\n\n"
18 docker logs -f $DOCKER_INSTANCE
```

1. The shebang line. Says that it is a script code and that the interpreter to execute the
code is bash and can be found in the /usr/bin/env environment
2. set -e says to the bash interpreter to exit the run at first error (to avoid catastrophes)
3. prompts "Now pulling the galaxykickstart docker image from DockerHub"
4. Pulls (Downloads) the Docker Image `artbio/biologiegenome` from
the [DockerHub repository](https://hub.docker.com/r/artbio/biologiegenome/)
5. reports this action to the terminal
6. Lines 6 to 14 are actually a single command to run an instance of the galaxykickstart
docker image. Note the `\` at ends of lines 7 to 13: this character `\` specify that the
code line is continued without line break for the bash interpreter.

    The line 6 starts with an `export DOCKER_INSTANCE=` instruction. This means that the result
    of the command between \` after the sign `=` will be put in the environmental variable
    `DOCKER_INSTANCE`, available system-wide.

    Now, the docker command (between \`) itself:

    Still in line 11, we have `docker run -d -p 80:80 -p 21:21 -p 8800:8800`.

    This means that a container will be run as a deamon (`-d ` option) and that the internal
    TCP/IP ports 80 (web interface) and 21 (ftp interface) of the docker instance will be mapped
    to the ports 80 and 21 of your machin (The VM in this case). Note that in the syntax `-p 80:80`,
    the host port is specified to the left of the `:` and the docker port is specified to the right
    of the `:`.
    
7. docker command continued: here we specify that the docker container acquires the root privileges
8. docker command continued: `-e GALAXY_CONFIG_ALLOW_USER_DATASET_PURGE=True`.

    The -e option specifies an environmental variable `GALAXY_CONFIG_ALLOW_USER_DATASET_PURGE`
    passed (`e`xported) to the docker container with the value `True`
    `galaxy_manage_trackster: true` with the string `galaxy_manage_trackster: false`
    in the ansible configuration file `groups/all`.

9. The environmental variable `GALAXY_CONFIG_ALLOW_LIBRARY_PATH_PASTE` is exported to
the docker container with the value `True`
10. The environmental variable `GALAXY_CONFIG_ENABLE_USER_DELETION` is exported to
the docker container with the value `True`
11. The environmental variable `GALAXY_CONFIG_ENABLE_BETA_WORKFLOW_MODULES` is exported to
the docker container with the value `True`

    Note that all these exports in the docker command correspond to advanced boiling/tuning of the docker container.
    You are not obliged to understand the details to get the container properly running.
12. Now the -v is important, better to understand it !

    -v stands for "volume". the `-v` option says to export the /tmp directory of the docker container
    to the /tmp directory of the host.
13. we also export the /export directory of the container (any docker container has or
should have by default an /export directory) to an /export directory of the host (your VM here).

    Note that if the /export directory does not exists at docker run runtime, it will be created.

    So it is important to understand the -v magics: every directory specified by the -v option will be shared
    between the docker container filesystem and the host filesystem. It is a mapping operation, so that
    the same directory is accessible either from inside the docker container or from inside the host.

    Now, if you stop and remove the docker container, all exported directory will persist in the host.
    If you don't do that, all operations performed with a container are lost when you stop this container !

14. This is the end of the docker run command. The docker image to be instantiated is specified.
15. reports to the terminal user
16. reports to the terminal user
17. reports to the terminal user
18. Now that the docker container is launched, you can access its logs with the command
`docker logs -f` (-f means continuous logging until keyboard interruption) followed by the
identification number of the docker container. We have put this ID in the variable `DOCKER_INSTANCE`
and we access to the content of this variable by prefixing the variable with a `$ `:
`docker logs -f $DOCKER_INSTANCE`



