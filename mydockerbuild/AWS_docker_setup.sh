#!/bin/bash
# Spencer Dodd
# sdodd@broadinstitute.org

# Update package information, ensure that APT works with the 
# https method, and that CA certificates are installed.
 sudo apt-get update
 sudo apt-get install apt-transport-https ca-certificates

 # add the new GPG key
 sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 \
 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D

# add the docker repo to apt sources
sudo echo deb https://apt.dockerproject.org/repo ubuntu-trusty main > /etc/apt/sources.list.d/docker.list

# update apt
sudo apt-get update

# purge the old repo if it exists
sudo apt-get purge lxc-docker

# verify the repo
apt-cache policy docker-engine

# install extra kernal package for aufs storage driver
sudo apt-get install linux-image-extra-$(uname -r)

# install app-armor
sudo apt-get install apparmor

# install docker
sudo apt-get install docker-engine

# start the docker engine
sudo service docker start

# make sure it was installed correctly
sudo docker run hello-world