## Installation of a Galaxy server with Ansible and the GalaxyKickStart playbook

### What is Ansible ?

![Ansible](images/ansible.png)

Ansible is an automation engine that automates configuration management and application
deployment.

Ansible reads instructions (Tasks) from a playbook and performs the indicated tasks on
target machines (Hosts), through an ssh connection.

There is no magics: everything an "administrator" can do using command lines of a linux OS,
can be automated with ansible that "wraps" these command lines.
The power of Ansible (and similar orchestration software, ie Puppet, Chief, etc.) comes
from the abstraction of complex suite of commands in the Ansible syntax.
Moreover, automation allows to reproduce exactly the desired configuration.
Finally, Ansible is `idempotent`: whatever the initial configuration, it brings the target
to the exact same final state. This is useful to repair a broken configuration.

### Ansible playbook - GalaxyKickStart

The Ansible "language" (Striclty speaking, Ansible language is *not* a programming language)
is structured. Thus a playbook is not necessarily a single flat file. Multiple tasks can be gathered in a file, a "role" is the execution of a set of tasks, and a playbook can execute multiple roles.
 
GalaxyKickStart is an Ansible playbook that will

- install basic dependencies needed for Galaxy
- Create and manage all the linux users involved in the deployment of Galaxy
- Install and configure the services required for Galaxy:
  - postgresql (database engine)
  - nginx (web server)
  - docker (containers)
  - proftpd (ftp server)
  - slurm (job manager)
  - supervisor (service manager)
- Configure Galaxy for using these services
- Install tools and workflows using the bioblend API.

The code of the GalaxyKickStart playbook is freely available at the ARTbio GitHub
Repository [https://github.com/ARTbio/GalaxyKickStart](https://github.com/ARTbio/GalaxyKickStart).

### Deployment

- start a GCE VM `2 procs, 7.5Gb RAM, Ubuntu 14.04, 100 Go disk, http enabled
- connect to you VM using the Google ssh console
- start an interactive session as root using the command `sudo -i`
- download the script `










