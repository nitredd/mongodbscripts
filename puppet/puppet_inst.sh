#!/usr/bin/env bash

wget https://apt.puppet.com/puppet7-release-focal.deb
sudo dpkg -i puppet7-release-focal.deb
sudo apt-get update
sudo apt install -y puppet-agent
PATH=$PATH:/opt/puppetlabs/bin
sudo `which puppet` module install puppetlabs-apt --version 8.0.2
