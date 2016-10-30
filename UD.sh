#!/bin/bash

#Example script to run at first boot via Openstack using the user_data and cloud-init.

#printf "\033c" #clear screen
#VERSION="$(grep -Eo "[0-9]\.[0-9]" /etc/redhat-release | cut -d . -f 1)"
#
#echo "Installing EPEL"
#sudo yum -y install epel-release
#
#echo "Installing Ansible and Git"
#sudo yum -y install ansible git gmp 2>&1
#
#echo "Cloning repo with Wordpress Playbook"
#git clone https://github.com/DEMO-JoWi/ansible-demo.git /tmp/app/ansible-demo 2>&1

#echo "Starting playbook"
#cd /tmp/app/ansible-demo
#sudo ansible-playbook -i hosts ./site.yml --connection=local 2>&1
#
#exit 0

echo "Update and install Apache2"
apt-get update
apt-get dist-upgrade --yes
apt-get install apache2 --yes

echo "Set up ufw firewall rules and enable"
ufw allow 22
ufw allow 80
ufw --force enable
