#!/usr/bin/env bash
set -e
apt-get update
apt-get -y remove docker docker.io containerd runc
echo "Installing docker-ce"
sudo apt-get install -y \
     apt-transport-https \
     ca-certificates \
     curl \
    gnupg-agent \
    software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository \
     "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
     $(lsb_release -cs) \
     stable"
apt-get update
apt-get install -y docker-ce docker-ce-cli containerd.io
