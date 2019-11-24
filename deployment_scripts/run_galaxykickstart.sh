#!/usr/bin/env bash
set -e
apt update -y
apt install -y python-pip python-dev python-setuptools git htop
echo "Upgrading pip"
pip install -U pip
/usr/local/bin/pip --version
/usr/local/bin/pip install ansible==2.7.4
ansible --version
git clone https://github.com/ARTbio/GalaxyKickStart.git -b $1
cd GalaxyKickStart/
ansible-galaxy install -r requirements_roles.yml -p roles/ -f
ansible-playbook -i inventory_files/galaxy-kickstart galaxy.yml
# su galaxy -c 'cd ~/galaxy/config && wget https://raw.githubusercontent.com/ARTbio/Run-Galaxy/master/deployment_scripts/sanitize_whitelist.txt'
echo "end of deployment\n"
# echo "Galaxy will restart to take into account last settings\n"
# supervisorctl restart galaxy:

