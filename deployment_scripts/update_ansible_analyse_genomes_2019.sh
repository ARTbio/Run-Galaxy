#!/usr/bin/env bash
set -e
rm -rf /root/GalaxyKickStart
git clone https://github.com/ARTbio/GalaxyKickStart.git -b $1
cd GalaxyKickStart/
ansible-galaxy install -r requirements_roles.yml -p roles/ -f
cp scripts/16cpu_job_conf.xml roles/galaxyprojectdotorg.galaxy-extras/templates/job_conf.xml.j2
cp scripts/configure_slurm.py.j2 roles/galaxyprojectdotorg.galaxy-extras/templates/configure_slurm.py.j2
ansible-playbook -i inventory_files/analyseGenomes galaxy.yml
echo "end of re-deployment, your Galaxy instance has been successfully updated\n"
