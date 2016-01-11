group { "docker": 
	ensure => present,
	gid => 1600,
}

group { "odoo":
	ensure => present,
	gid => 1500,
	require => Group['docker']
}

user { "odoo":
	ensure => present,
	gid => "odoo",
	shell => "/bin/bash",
	groups => ['docker'],
	home => "/opt/odoo",
	require => Group['odoo'],
}

file { "/opt/odoo/":
	ensure => "directory",
	owner => 'odoo',
	group => 'odoo',
	mode => '755',
}

ssh_authorized_key { 'odoo': 
	user => 'root',
	type => 'ssh-rsa',
	key => 'AAAAB3NzaC1yc2EAAAADAQABAAAAgQDqptY8E1zp/2Qsi9+wnhIUUNwBGOjtBcacAxkxwXEwbW0v/i/ApxmvtoUxPL1AZ2IcLBE/qL7ZEZq8TUVfLNw/X81oq7pZxh1j11Y6LrFKc7UXzUpwizwJ48FiBbuRfBMRjGZJO+c3k+sdkknz6Tm5DxBF+qnn3tsb11oSlyDHMw==',
}