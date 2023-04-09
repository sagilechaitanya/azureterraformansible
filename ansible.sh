#!/bin/bash
echo "started script"
sudo apt-get update
echo "adding sofware properties"
sudo apt-get install software-properties-common -y
echo "adding ansible repository"
sudo add-apt-repository --yes --update ppa:ansible/ansible
echo "ansible installation started"
sudo apt-get install ansible -y
echo "successfully installed"
echo ansible version
ansible --version
echo "printing"
seq 10

