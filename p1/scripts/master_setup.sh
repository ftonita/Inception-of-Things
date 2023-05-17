#!/bin/bash

echo "Master | K3S Starting"
echo "========== Configuring&Updating YUM Repos"
sudo sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-*
sudo sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*
sudo yum update -y
echo "========== Configuring&Updating YUM Repos COMPLETED"
export INSTALL_K3S_EXEC="--write-kubeconfig-mode=644 --tls-san $(hostname) --node-ip $1  --bind-address=$1 --advertise-address=$1 "
curl -sfL https://get.k3s.io |  sh -
sudo cp /var/lib/rancher/k3s/server/node-token /vagrant/scripts/ # копирование в общедоступную папку, чтобы все пользователи могли использовать
sudo yum install net-tools -yq # установка ifconfig и тп
echo "[$(hostname)] SETUP SUCCESSFULL"