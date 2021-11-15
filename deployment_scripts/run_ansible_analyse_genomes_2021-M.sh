#!/usr/bin/env bash
set -e
apt update -y
apt install -y ansible
ansible --version
git clone https://github.com/ARTbio/galaxykickstart -b Analyse_genomes
cd galaxykickstart/
ansible-galaxy install -r requirements_roles.yml -p roles/ -f
ansible-playbook -i inventory_files/Analyse_genomes galaxy.yml
cd /home/galaxy/tool_dependencies
rm -rf _conda
wget http://usegalaxy.sorbonne-universite.fr/nextcloud/index.php/s/s6AAtDwR5at46bb/download/_conda.pigz.tar.gz
apt install -y pigz
tar -I pigz -xf _conda.pigz.tar.gz
chown -R galaxy:galaxy _conda
rm -rf _conda_tar.gz
cd ~/galaxykickstart
ansible-playbook -i inventory_files/Analyse_genomes galaxy_tool_install.yml
echo "end of deployment\n"
