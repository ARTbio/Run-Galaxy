#!/usr/bin/env bash
set -e
apt update -y
apt install -y python-pip python-dev python-setuptools git htop
git clone https://github.com/galaxyproject/galaxy.git -b release_18.09
cd galaxy/
cp config/galaxy.yml.sample config/galaxy.yml
sed -i "s/http: 127.0.0.1:8080/http: 0.0.0.0:80/" config/galaxy.yml
sed -i "s/#admin_users: ''/admin_users: 'admin@galaxy.org'/" config/galaxy.yml
sh run.sh
