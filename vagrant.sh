#!/bin/bash

#Initialize vagrant file
vagrant init ubuntu/focal64

#use a here document to edit the vagrantfile
cat <<EOL > Vagrantfile
Vagrant.configure("2") do |config|

  config.vm.define "slave" do |slave|
    slave.vm. hostname = "slave"
    slave.vm.box = "ubuntu/focal64"
    slave.vm.network "private_network", ip: "192.168.23.1"


    #provisioning script
  
    slave.vm.provision "shell", inline: <<-SHELL
    sudo apt-get update && sudo apt-get upgrade -y
    sudo apt install sshpass -y
    #edit the ssh file to change password authentication from no to yes
    sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
    sudo systemctl restart sshd
    #install DNS utility to allow machines to be able to interact with eachother
    sudo apt-get install -y avahi-daemon libnss-mdns
    SHELL
  end

  config.vm.define "master" do |master|

    master.vm.hostname = "master"
    master.vm.box = "ubuntu/focal64"
    master.vm.network "private_network", ip: "192.168.23.2"
   
    #provisioning script for master
    master.vm.provision "shell", inline: <<-SHELL
    sudo apt-get update && sudo apt-get upgrade -y
    sudo apt-get install -y avahi-daemon libnss-mdns
    sudo apt install sshpass -y
    sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
    sudo systemctl restart sshd
    SHELL
  end
 
   config.vm.provider "virtualbox" do |vb|
     vb.memory = "1024"
     vb.cpus = "2"
   end
end
EOL

#bring up the machines
vagrant up

#run script from another file
source lamp.sh
 