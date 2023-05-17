#!/bin/bash

echo "Worker Setup Start"
echo "========== Configuring&Updating YUM Repos"
sudo sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-*
sudo sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*
sudo yum update -y
echo "========== Configuring&Updating YUM Repos COMPLETED"
export TOKEN_FILE="/vagrant/scripts/node-token"
export INSTALL_K3S_EXEC="agent --server https://$1:6443 --token-file $TOKEN_FILE --node-ip=$2"
curl -sfL https://get.k3s.io | sh -
sudo yum install net-tools -y
echo "[$(hostname)] SETUP SUCCESSFULL"