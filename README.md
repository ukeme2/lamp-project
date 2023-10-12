# Project: Deployment of Vagrant Ubuntu Cluster with LAMP Stack.

# Project Description

This project aims to set up two vagrant machines with a LAMP (Linux, Apache, MySQL, PHP) stack.

# Prerequisites

Before getting started, ensure you have the following software installed:

. Vagrant

. VirtualBox

# Getting started

The first thing to do is create a directory you want this project to run then cd into the directory and create do bash script file where the scrip will be written e.g (vagrant.sh).

Once that is done you open in a text editor like nano or vim and write your script.

# first step

Evey bash script starts with a shebang. AFter that we initialize a vagrant environment using the command _vagrant init_ to create a vagrant file

![init](/pictures/init.png)

# Second step

![slave](/pictures/slave.png)

Here we use a here document to edit the vagrantfile without having to go into that file.

in this picture above the first machine is being configured with the hostname, virtual machine box (ubuntu/focal64) and the network. It is also given a private ip address.

It also has a provisioning script to update packages, install ssh pass, install Dns utility and to edit the ssh file to change password authentication from no to yes.

A provisioning script is like a script with a list of things to do as machine boots up.

# Third step

![master](/pictures/master.png)

We configure the second machine (master) and install some necessary things to the machine too

In the last section of code in the picture above is the configuration of the memory of the two machines being setup.

Then bring up the machines by running _VAGRANT UP_

# Script for lamp stack installation

![lamp](/pictures/lamp.png)

This script in the picture above works for both master and slave.

The first line is basically saying on a new line echo "updating apt packages and upgrading latest patches".

the first step is to update the packages _sudo apt update -y_

_sudo ufw allow in "Apache"_ is used to allow incoming network traffic on a specific port associated with the Apache web server.

_sudo ufw status_ is checking if firewall is active.

the next step is installing mysql.

The commands in the next step are used to set the ownership and permissions of the /var/www directory and its contents for a web server. Specifically, they are setting the ownership to the www-data user and group, which is a common configuration for Apache or other web servers.

The next step is to install php

The next step is to enable apache modules and php extentions

Next is to modify the directory index.

Then reload apache

Echo lamp stack installation complete.

![source](/pictures/source.png)

Now go back to the vagrant script to add the source command and the file where the lamp installation script is located.
