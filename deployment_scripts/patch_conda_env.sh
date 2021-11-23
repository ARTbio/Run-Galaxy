#!/usr/bin/env bash
set -e
apt update -y
apt install -y pigz
echo "deleting conda env\n"
cd /home/galaxy/tool_dependencies/
rm -rf _conda* conda.lock
echo "Dowloading _conda.pigz.tar.gz from Amazon S3\n"
wget https://mydeepseqbucket.s3.amazonaws.com/_conda.pigz.tar.gz
echo "extracting conda archive... zzzz\n"
tar -I pigz -xf _conda.pigz.tar.gz
echo "Ensure _conda is owned by galaxy user\n"
chown -R galaxy:galaxy _conda
echo "Leaving _conda.pigz.tar.gz in /home/galaxy/tool_dependencies/\n"
echo "restarting Galaxy server\n"
supervisorctl restart galaxy:
