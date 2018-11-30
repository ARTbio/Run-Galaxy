#!/usr/bin/env bash
set -e
apt update -y
apt install -y python-pip python-dev python-setuptools git htop
echo "Upgrading pip"
pip install -U pip
pip --version
/usr/local/bin/pip install ansible==2.4
ansible --version
git clone https://github.com/ARTbio/GalaxyKickStart.git -b biogen2018
cd GalaxyKickStart/
ansible-galaxy install -r requirements_roles.yml -p roles/ -f
ansible-playbook -i inventory_files/galaxy-kickstart galaxy.yml
echo "Sleeping 15 sec before restarting Galaxy server"
echo "zzzz zzzz..."
sleep 15
supervisorctl restart galaxy:
