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








