#!/bin/bash

# Configure firewall
firewall-offline-cmd --add-port=8529/tcp
systemctl restart firewalld

# Install ArangoDB
cd /etc/yum.repos.d/
curl -OL https://download.arangodb.com/arangodb34/RPM/arangodb.repo
yum -y install arangodb3-3.4.5

systemctl stop arangodb3.service

# Change root password generated by installation
ARANGODB_DEFAULT_ROOT_PASSWORD=${password} arango-secure-installation

# Start & enable ArangoDB service
systemctl start arangodb3.service
systemctl enable arangodb3.service
