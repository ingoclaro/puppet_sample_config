class base::packages {
  package { ['mlocate', 'sed', 'gzip', 'bzip2', 'tar', 'grep', 'findutils', 'patch']:
    ensure => installed,
  }
  package { ['wget', 'curl', 'rsync']:
    ensure => installed,
  }
}
