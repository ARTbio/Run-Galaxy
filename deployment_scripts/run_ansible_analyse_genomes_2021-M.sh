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
wget https://usegalaxy.sorbonne-universite.fr/nextcloud/index.php/s/w2c6GjXCfwPkwiW/download/_conda.pigz.tar.gz
apt install -y pigz
echo "Uncompressing conda archive\n"
tar -I pigz -xf _conda.pigz.tar.gz
chown -R galaxy:galaxy _conda
cd ~/galaxykickstart
ansible-playbook -i inventory_files/Analyse_genomes galaxy_tool_install.yml
echo "end of Galaxy deployment\n"
echo "now patching conda env, this may take a few minutes"
cd /home/galaxy/tool_dependencies/
rm -rf _conda* conda.lock
wget https://storage.googleapis.com/analyse-genome-coupon-1/_conda.pigz.tar.gz
tar -I pigz -xf _conda.pigz.tar.gz
chown -R galaxy:galaxy _conda
echo "Removing _conda.pigz.tar.gz from /home/galaxy/tool_dependencies/\n"
rm _conda.pigz.tar.gz
echo "restarting Galaxy server\n"
supervisorctl restart galaxy:
echo "******** Your Galaxy server is now up and running ! ********\n"
