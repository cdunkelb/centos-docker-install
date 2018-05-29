#!/bin/bash
# remove existing docker repositories
rm /etc/yum.repos.d/docker*.repo

# Replace <DOCKER-EE-URL> with your URL in the following command
export DOCKERURL="<DOCKER-EE-URL>"

# Store the value of the variable, DOCKERURL (from the previous step), in a yum variable in /etc/yum/vars/
sh -c 'echo "$DOCKERURL/centos" > /etc/yum/vars/dockerurl'

# Install required packages: yum-utils provides the yum-config-manager utility, and device-mapper-persistent-data and
# lvm2 are required by the devicemapper storage driver
yum install -y yum-utils \
  device-mapper-persistent-data \
  lvm2

# Add the Docker EE stable repository:
yum-config-manager \
    --add-repo \
    "$DOCKERURL/centos/docker-ee.repo"

# Install the latest version of Docker EE
sudo yum -y install docker-ee

# To install a specific version of Docker EE (recommended in production), list versions and install
# sudo yum list docker-ee  --showduplicates | sort -r
# sudo yum -y install <FULLY-QUALIFIED-PACKAGE-NAME>

# Start Docker
sudo systemctl start docker

#Verify that Docker EE is installed correctly by running the hello-world image
sudo docker run hello-world