#!/usr/bin/env bash

# THIS SCRIPT WILL CREATE SSH KEYPAIR AND DISTRIBUTE ACROSS ALL NODES

ssh-keygen -b 2048 -t rsa -f /home/vagrant/.ssh/id_rsa -q -N ""

# LOOPING THROUGH AND DISTRIBUTING THE KEY

for val in controller managed-3 managed-4 
do 
    echo "-------------------- COPYING KEY TO ${val^^} NODE ------------------------------"
    sshpass -p 'vagrant' ssh-copy-id -o "StrictHostKeyChecking=no" vagrant@$val 
done

# CREATE THE INVENTORY FILE

PROJECT_DIRECTORY="/home/vagrant/ansible_project/"
ANSIBLE_BOOK_DIRECTORY="/home/vagrant/ansible_books/"

mkdir -p $PROJECT_DIRECTORY
cd $PROJECT_DIRECTORY

# Creating the inventory file for all 3 nodes to run some adhoc command.

echo -e "controller\n\n[ubuntu1]\nmanaged-3\n\n[ubuntu2]\nmanaged-4" > inventory
echo -e "[defaults]\ninventory = inventory" > ansible.cfg
echo -e "-------------------- RUNNING ANSBILE ADHOC COMMAND - UPTIME ------------------------------"

# running adhoc command to see if everything is fine

ansible all -i inventory -m "shell" -a "uptime"

# Creating the inventory file for two nodes to run playbook
cd ..
cd $ANSIBLE_BOOK_DIRECTORY 

echo -e "[ubuntu1]\nmanaged-3\n\n[ubuntu2]\nmanaged-4" > inventory

echo

