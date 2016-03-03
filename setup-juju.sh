#!/bin/bash

# This script is meant to run on a new LXC image to install and configure Juju.

set -ex

sleep 3
apt-get update -qq --fix-missing
apt-get install -qy software-properties-common
apt-add-repository -y ppa:juju/devel
# stable ppa is required for charm-tools
apt-add-repository -y ppa:juju/stable
apt-get update -qq --fix-missing

apt-get -qy install juju-core2
apt-get -qy install byobu vim charm-tools openssh-client
apt-get -qy install virtualenvwrapper python-dev cython git

# Ubuntu user is already added to the LXC images.

HOME=/home/ubuntu

RC=${HOME}/.bashrc
echo "export JUJU_HOME=${HOME}/.juju" >> $RC
echo "export JUJU_REPOSITORY=${HOME}" >> $RC
echo "export PROJECT_HOME=${HOME}" >> $RC
echo "export JUJU_DATA=${HOME}/.local/share/juju" >> $RC

echo "echo 'welcome to juju 2.0'" >> $RC

chown -R ubuntu:ubuntu ${HOME}