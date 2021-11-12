#!/usr/bin/env bash
set -e
git clone https://github.com/galaxyproject/galaxy.git -b release_21.05
cd ~/galaxy/
cp config/galaxy.yml.sample config/galaxy.yml
sed -i "s/http: 127.0.0.1:8080/http: 0.0.0.0:80/" config/galaxy.yml
sed -i "s/#admin_users: null/admin_users: 'admin@galaxy.org'/" config/galaxy.yml
rm -rf ~/galaxy/client ~/galaxy/static
cd ~/galaxy && wget https://mydeepseqbucket.s3.amazonaws.com/bare.client.tar.gz \
    https://mydeepseqbucket.s3.amazonaws.com/bare.static.tar.gz
cd ~/galaxy && tar -xzf bare.static.tar.gz && tar -xzf bare.client.tar.gz
if [[ -d "/mnt/mydatalocal" ]]
    then
    mv ~/galaxy /mnt/mydatalocal
    cd /mnt/mydatalocal
fi
sh run.sh
