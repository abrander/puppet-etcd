# == Class etcd::config
#
class etcd::config {
  case $::osfamily {
    'RedHat' : {
      file { '/etc/sysconfig/etcd':
        ensure  => present,
        owner   => $etcd::user,
        group   => $etcd::group,
        mode    => '0644',
        content => template('etcd/etcd.sysconfig.erb'),
      }
    }
    'Debian' : {
      # Use file defaults from Debian package
      file { '/etc/default/etcd':
        ensure  => file,
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        content => template('etcd/etcd.default.erb')
      }
    }
    default  : {
      fail("OSFamily ${::osfamily} not supported.")
    }
  }
}
