#!/usr/bin/env bash
set -e

# - name: Add Docker repository key
#  apt_key: keyserver=hkp://p80.pool.sks-keyservers.net:80 id=58118E89F3A912897C070ADBF76221572C52609D
#  when: configure_docker

sudo apt-key adv --recv-keys --keyserver hkp://p80.pool.sks-keyservers.net:80 58118E89F3A912897C070ADBF76221572C52609D


# - name: Add Docker repository
#   apt_repository: repo='deb https://apt.dockerproject.org/repo ubuntu-{{ ansible_distribution_release }} main' update_cache=no #'
#   when: configure_docker

sudo add-apt-repository "deb https://apt.dockerproject.org/repo ubuntu-trusty main"

# - name: Update APT cache
#   apt: update_cache=yes

sudo apt-get update -y

#  - name: Install Docker package
#   apt: pkg={{ item }} state={{ apt_package_state }} install_recommends=no
#   with_items:
#     - "{{ docker_package }}"
#   when: install_packages

sudo apt-get -y install docker-engine
