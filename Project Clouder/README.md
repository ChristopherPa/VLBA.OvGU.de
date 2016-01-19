# *Odoo* and *clouder* installation automation

The files at hand allow the automated installation of *clouder* (https://github.com/clouder-community/clouder) for *odoo* (https://www.odoo.com).
They serve to establish a common baseline for debugging clouder installation problems.

With them two virtual machines (vm) using the tools *vagrant* and *puppet* are set up.
On the first vm *odoo* and *clouder's* code  are installed, and on the second vm *docker* is installed.
The user can than proceed with the manual installation and configuration of *clouder* as described here: http://doc.goclouder.net/


# Attention: FOR TESTING ONLY!

This installation automation of clouder is not for production use.
The ssh-keys in this archive are included for reasons of convenience and ease of the odoo+clouder setup routine. But, as they are part of this public repository they must not be used in production as attackers could access your virtual boxes.

# Software requirements for installation:

- Vagrant
- Vagrant Plugins:
  - Vagrant Cachier
  - Vagrant Hostmanager

- GitBash (Windows)
- Oracle Virtual Box

# Installation:

1. Download and install Oracle Virtual Box (download here: https://www.virtualbox.org/wiki/Downloads )
2. Download and install GitBash (download here: https://git-for-windows.github.io/ )
	* configure GitBash to check out UNIX-styled line endings (LF) otherwise you will have a problem with the odoo start script and configuration file
3. Download and install Vagrant (download here: https://www.vagrantup.com/downloads.html )
4. Install the Vagrant Plugins.	
  1. Open/Start Terminal (Linux / Mac) or e.g. GitBash (Windows)
  2. Type following commands in the console to install the Vagrant Plugins:
	* $ vagrant plugin install vagrant-cachier
	* $ vagrant plugin install vagrant-hostmanager	
5. Download the files for the automated clouder+docker installation from https://github.com/ChristopherPa/VLBA.OvGU.de/tree/master/Project%20Clouder
6. Start the GitBash and move via the console to the main directory of the downloaded file. (the main directory includes the start.sh !!!)
7. To install the clouder+docker VM's type the following command in the console:
  * $ ./start.sh	
	The installation begins and takes a few minutes.
8. After the installation has completed restart manually the odoo server in the clouder VM.
  1. Open/Start Terminal (Linux / Mac) or e.g. GitBash (Windows)
  2. Connect to clouder VM with following command:
  	* $ vagrant ssh clouder
  3. Restart odoo server with following commands: 
  	* $ sudo service odoo-server stop
  	* $ sudo service odoo-server start
  4. Exit the VM
 
9. Now connect via the Browser to Clouder (http://clouder.local:8069 or http://192.168.33.10:8069)
  
# Usage:

1. cd to the directory containing this file
2. run ./start.sh
3. Odoo will be accessible via a browser at http://clouder.local:8069
