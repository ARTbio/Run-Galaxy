#!/usr/bin/env bash
set -e
apt update -y
apt install -y python-pip python-dev python-setuptools git htop
echo "Upgrading pip"
pip install -U pip
pip --version
pip install cryptography==2.2.2
pip install ansible==2.4
ansible --version
git clone https://github.com/ARTbio/GalaxyKickStart.git -b pasteur-2018
cd GalaxyKickStart
ansible-galaxy install -r requirements_roles.yml -p roles/ -f
# edit group_vars/all with /export --> /mnt before continuing
#ansible-playbook -i inventory_files/galaxy-kickstart galaxy.yml
#echo "Sleeping 15 sec before restarting Galaxy server"
#echo "zzzz zzzz..."
#sleep 15
#supervisorctl restart galaxy:
