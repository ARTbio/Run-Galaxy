#!/usr/bin/env bash
set -e
apt-get update -y
apt-get install -y python-pip python-dev python-setuptools git htop
pip install -U pip
pip install ansible==2.2
ansible --version
git clone https://github.com/ARTbio/GalaxyKickStart.git
cd GalaxyKickStart/
ansible-galaxy install -r requirements_roles.yml -p roles/ -f
echo "\nEditing group_vars/all\n"
sed -i -e 's/galaxy_manage_trackster: true/galaxy_manage_trackster: false/' group_vars/all
ansible-playbook -i inventory_files/galaxy-kickstart galaxy.yml
echo "\nSleeping 15 sec before restarting Galaxy server\n"
echo "zzzz zzzz..."
sleep 15
supervisorctl restart galaxy:
