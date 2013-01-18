package {
  [
    'build-essential',
    'dpkg-dev',
    'ruby1.9.3',
    'rubygems1.9.1',
    'git-core',
    'libssl-dev',
    'libreadline6-dev',
    'zlib1g-dev',
    'leiningen',
  ]:
    ensure => installed,
}

package { 'fpm':
  ensure   => installed,
  provider => gem,
}
