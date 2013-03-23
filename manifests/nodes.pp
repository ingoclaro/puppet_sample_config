node 'basenode' {
  include epel
  include atomic
  include repoforge

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

node 'puppet' inherits basenode {
  class { 'apache':
    default_mods => false,
  }

  apache::mod { 'authz_host': }
  apache::mod { 'dir': }
  apache::mod { 'mime': }
  apache::mod { 'log_config': }
  apache::mod { 'alias': }
  apache::mod { 'autoindex': }
  apache::mod { 'negotiation': }
  apache::mod { 'setenvif': }

  apache::vhost { 'default':
    port            => '80',
    docroot         => '/vagrant/web/',
    configure_firewall => true,
    ssl => false,
  }
}
