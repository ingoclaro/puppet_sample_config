class base {
  file { '/etc/hosts':
    ensure => present,
    content => '',
    owner => 'root',
    group => 'root',
    mode => '0644',
  }

  host { 'localhost4':
    ensure       => present,
    ip           => '127.0.0.1',
    host_aliases => ['localhost.localdomain', 'localhost4', 'localhost4.localdomain4'],
    subscribe => File['/etc/hosts'],
  }
  host { 'localhost6':
    ensure       => present,
    ip           => '::1',
    host_aliases => ['localhost.localdomain', 'localhost6', 'localhost6.localdomain6'],
    subscribe => File['/etc/hosts'],
  }

  host { 'hostname':
    ensure       => present,
    name         => $hostname,
    ip           => $ipaddress_eth0,
    subscribe => File['/etc/hosts'],
  }

}

node 'puppet' {
}
