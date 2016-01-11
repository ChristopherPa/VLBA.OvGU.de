$odoopackages = [ 'ghostscript', 'graphviz', 'antiword', 'git', 'libpq-dev', 'poppler-utils', 'curl', 'wget', 'python-pip', 'xfonts-75dpi', 'xfonts-base' ]
$pythonpackages = ['python-dateutil', 'python-pypdf', 'python-requests', 'python-feedparser', 'python-gdata', 'python-ldap', 'python-libxslt1', 'python-lxml', 'python-mako', 'python-openid', 'python-psycopg2', 'python-pybabel', 'python-pychart', 'python-pydot', 'python-pyparsing', 'python-reportlab', 'python-simplejson', 'python-tz', 'python-vatnumber', 'python-vobject', 'python-webdav', 'python-werkzeug', 'python-xlwt', 'python-yaml', 'python-zsi', 'python-docutils', 'python-psutil', 'python-unittest2', 'python-mock', 'python-jinja2', 'python-dev', 'python-pdftools', 'python-decorator', 'python-openssl', 'python-babel', 'python-imaging', 'python-reportlab-accel', 'python-paramiko', 'python-software-properties']

package { $odoopackages: ensure => 'installed' }
package { $pythonpackages: ensure => 'installed' }

#paramiko bug (Error : Incompatible ssh peer (no acceptable kex algorithm)
package { ['python-ecdsa'] : ensure => 'installed' }

group { "odoo":
	ensure => present,
	gid => 1500,
}

user { "odoo":
	ensure => present,
	gid => "odoo",
	shell => "/bin/bash",
	home => "/opt/odoo",
	require => Group['odoo'],
}

file { "/etc/odoo-server.conf":
	ensure => "present",
	owner => "odoo",
	group => "odoo",
	mode => 640,
	source => 'puppet:///modules/clouderfiles/odoo-server.conf',
	require => User['odoo']
}

file { "/etc/init.d/odoo-server":
	ensure => "present",
	owner => 'root',
	group => 'odoo',
	mode => '755',
	source => 'puppet:///modules/clouderfiles/odoo-server.sh',
}

file {'/var/log/odoo':
	ensure => directory,
	owner => 'odoo',
	group => 'root',
	mode => '644'
}

file { '/opt/odoo':
	ensure => directory,
	owner => 'odoo',
	group => 'odoo',
	mode => '744',
}

file { '/opt/odoo_downloads':
	ensure => directory,
	owner => 'odoo',
	group => 'odoo',
	mode => '744',
}

class { 'postgresql::server': }

postgresql::server::role { 'odoo':
  password_hash => postgresql_password('odoo', 'odoo'),
  superuser => true,
}
postgresql::server::role { 'postgres':
  password_hash => postgresql_password('postgres', 'postgres'),
  superuser => true,
}