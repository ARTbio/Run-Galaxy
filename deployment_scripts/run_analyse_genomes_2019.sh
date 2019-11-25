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
cp scripts/8cpu_job_conf.xml roles/galaxyprojectdotorg.galaxy-extras/templates/job_conf.xml.j2
ansible-playbook -i inventory_files/analyseGenomes galaxy.yml
echo "end of deployment\n"
