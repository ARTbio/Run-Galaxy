#!/usr/bin/env bash
set -e
apt update -y
apt install -y pigz
echo "deleting conda env\n"
cd /home/galaxy/tool_dependencies/
rm -rf _conda* conda.lock
echo "Dowloading _conda.pigz.tar.gz from Google Cloud Storage\n"
wget https://storage.googleapis.com/analyse-genome-coupon-1/_conda.pigz.tar.gz
echo "extracting conda archive. This may take few minutes zzzz\n"
tar -I pigz -xf _conda.pigz.tar.gz
echo "Ensure _conda is owned by galaxy user\n"
chown -R galaxy:galaxy _conda
echo "Removing _conda.pigz.tar.gz from /home/galaxy/tool_dependencies/\n"
rm _conda.pigz.tar.gz
echo "restarting Galaxy server\n"
supervisorctl restart galaxy:
