#! /bin/sh
#boot the ubuntu image without configuring it
vagrant up --no-provision clouder

#fixing grub problem
vagrant ssh -c "echo \"set grub-pc/install_devices /dev/sda\" | sudo debconf-communicate ;\
sudo apt-get -y -qq update ;\
sudo apt-get -y -qq upgrade" clouder

#upgrade the package resources and removing unnecessary packages
vagrant ssh -c "sudo apt-get dist-upgrade --yes ;\
sudo apt-get autoremove" clouder

#configure the vagrant box as described in the init.pp, using puppet (puppet is preinstalled on the vagrant box)
vagrant provision clouder

#installing some prerequiste packages
vagrant ssh -c "sudo pip install passlib ;\
get http://download.gna.org/wkhtmltopdf/0.12/0.12.2.1/wkhtmltox-0.12.2.1_linux-trusty-amd64.deb ;\
sudo dpkg -i wkhtmltox-0.12.2.1_linux-trusty-amd64.deb" clouder

#installing odoo
vagrant ssh -c "sudo -u odoo git clone https://www.github.com/odoo/odoo --depth 1 --branch 8.0 /opt/odoo ;\
sudo update-rc.d odoo-server defaults" clouder

#installing clouder
vagrant ssh -c "sudo -u odoo git clone https://github.com/clouder-community/clouder --depth 1 --branch 8.0 /opt/odoo_downloads/clouder-8.0 ;\
sudo -u odoo cp -r /opt/odoo_downloads/clouder-8.0/clouder* /opt/odoo/addons ;\
sudo pip install -U erppeek" clouder

#install python-paramiko_1.15.2-1_all (Error : Incompatible ssh peer (no acceptable kex algorithm))
vagrant ssh -c "sudo dpkg -i /vagrant/modules/clouderfiles/files/python-paramiko_1.15.2-1_all.deb" clouder

#starting odoo
vagrant ssh -c "sudo service odoo-server start" clouder

