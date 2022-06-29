#!/usr/bin/env bash

# vagrant by default creates its own keypair for all the machines. Password based authentication will be disabled by default and enabling it so password based auth can be done.

sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
sudo systemctl restart sshd

# Supressing the banner message everytime you connect to the vagrant box.

touch /home/vagrant/.hushlogin

# Updating the hosts file for all the 3 nodes with the IP given in vagrantfile

# 192.168.10.3 controller.ansible.com controller
# 192.168.10.4 managed1.ansible.com managed1
# 192.168.10.5 managed2.ansible.com managed2

echo -e "192.168.10.2 ansible-controller controller\n192.168.10.3 ansible-managed-3 managed-3\n192.168.10.4 ansible-managed-4 managed-4" >> /etc/hosts

# Installing necessary packages 

sudo apt-get update && sudo apt-get -y install curl wget net-tools iputils-ping python3-pip sshpass

# Install ansible using pip only in controller node

if [[ $(hostname) = "ansible-controller" ]]; 
then
  sudo pip3 install ansible
fi
