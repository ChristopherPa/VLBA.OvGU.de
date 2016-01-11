#! /bin/sh
#boot the ubuntu image without configuring it
vagrant up --no-provision docker

#fixing grub problem
vagrant ssh -c "echo \"set grub-pc/install_devices /dev/sda\" | sudo debconf-communicate ;\
sudo apt-get -y -qq update ;\
sudo apt-get -y -qq upgrade" docker

#upgrade the package resources and removing unnecessary packages
vagrant ssh -c "sudo apt-get dist-upgrade --yes ;\
sudo apt-get autoremove" docker

#configure the vagrant box as described in the init.pp, using puppet (puppet is preinstalled on the vagrant box)
vagrant provision docker

#installing docker
vagrant ssh -c "curl https://get.docker.com/ | sudo sh ;\
sudo update-rc.d docker defaults" docker

vagrant ssh -c "sudo service docker start" docker