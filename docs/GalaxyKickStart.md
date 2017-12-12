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

- start a GCE VM `2 procs, 7.5Gb RAM, Ubuntu 14.04, 100 Go disk, http enabled`
- connect to you VM using the Google ssh console
- start an interactive session as root using the command `sudo -i`
- download the script `run_galaxykickstart.sh` using the command `wget https://raw.githubusercontent.com/ARTbio/Run-Galaxy/master/deployment_scripts/run_galaxykickstart.sh`
- run the script using the command `sh run_galaxykickstart.sh`
- Connect to your ansible-deployed "GalaxyKickStart" instance:
    
    Just click on the url displayed in your Google Cloud Engine Console.


#### the run_galaxykickstart.sh script explained

NB: in the following code, numbers in line heads should be removed to run the script.

```
1  #!/usr/bin/env bash
2  set -e
3  apt-get install -y python-pip python-dev python-setuptools git htop
4  echo "Upgrading pip to v 1.9\n"
5  pip install -U pip
6  pip --version
7  /usr/local/bin/pip install ansible==2.2
8  ansible --version
9  git clone https://github.com/ARTbio/GalaxyKickStart.git
10 cd GalaxyKickStart/
11 ansible-galaxy install -r requirements_roles.yml -p roles/ -f
12 echo "\nEditing group_vars/all\n"
13 sed -i -e 's/galaxy_manage_trackster: true/galaxy_manage_trackster: false/' group_vars/all
14 ansible-playbook -i inventory_files/galaxy-kickstart galaxy.yml
15 echo "\nSleeping 15 sec before restarting Galaxy server\n"
16 echo "zzzz zzzz..."
17 sleep 15
18 supervisorctl restart galaxy:
```

1. The shebang line. Says that it is a script code and that the interpreter to execute the
code is bash and can be found in the /usr/bin/env environment
2. set -e says to the bash interpreter to exit the run at first error (to avoid catastrophes)
3. install `python-pip`, `python-dev`, `python-setuptools` (these 3 packages are required to
install pip), `git` (to clone and manage GitHub repositories) and `htop` (a monitoring tool)
using the package installer `apt-get`
4. Is just a command to inform the user about run state. This will prompt
"Upgrading pip to v 1.9" in the console
5. does what is stated before ! : this is the command to upgrade the pip program that was
installed with installation of `python-pip`, `python-dev` and `python-setuptools`.
`pip` is a recursive acronym that can stand for either "Pip Installs Packages" or
"Pip Installs Python".
6. will prompt the version of pip in the console
7. install `ansible`, version 2.2, using `pip` !
8. will prompt the version of ansible in the console
9. clone the GalaxyKickStart Repository available at https://github.com/ARTbio/GalaxyKickStart.git,
creating locally the `GalaxyKickStart` folder.
10. Change directory, ie goes to /root/GalaxyKickStart
11. says to ansible to install additional roles (collection of files to control ansible)
which are not the the GalaxyKickStart repository but whose address is stated in the file
`requirements_roles.yml`. These roles will be installed in the subdirectory
`/root/GalaxyKickStart/roles/`. NB: `ansible-galaxy` has *nothing* to do with Galaxy,
the name of this ansible command is serendipitous.
12. warns about the next command
13. This sed command will automatically search and replace the string
`galaxy_manage_trackster: true` with the string `galaxy_manage_trackster: false`
in the ansible configuration file `groups/all`.
14. triggers the play of the playbook `galaxy.yml` by ansible. The target host of the playbook
is defined in the file `inventory_files/galaxy-kickstart`, as well as how ansible will interact with the target.
Here, we play the playbook on the same computer (localhost).
15. Prompt the effect of the command 17.
16. Prompt the effect of the command 17.
17. sleep for 15 seconds. This is to let the Galaxy server starting quietly.
18. use supervisor to restart the galaxy server: this is to load the more recent configuration
files that may have been modified by the playbook *after* the Galaxy server started.







