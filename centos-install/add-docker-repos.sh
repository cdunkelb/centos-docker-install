#!/bin/bash
rm /etc/yum.repos.d/docker*.repo
export DOCKERURL="<DOCKER-EE-URL>"
sh -c 'echo "$DOCKERURL/centos" > /etc/yum/vars/dockerurl'
yum install -y yum-utils \
  device-mapper-persistent-data \
  lvm2
yum-config-manager \
    --add-repo \
    "$DOCKERURL/centos/docker-ee.repo"
