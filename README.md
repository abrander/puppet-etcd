About
------
This puppet module installs and configures the official Debian packages version of etcd.

*WARNING*: This module probably has some rough edges. PR me with your 
modifications! (And tests!)

It is designed around the current version of etcd in Debian Testing (at time of this writing), 
2.0.8. 

Examples
---------
Simplest invocation, installs etcd via packages and makes sure it runs on localhost:

    class { 'etcd': }

Parameters
----------
This module is in flux. See init.pp for all parameters and their defaults.


Requirements
------------
It assumes you have a package available called etcd.

Example configuration
---------------------

```
# Set up a 3-node cluster and some proxies
$etcdcluster = [
  'agent1.example.com=http://agent1.example.com:2380',
  'agent2.example.com=http://agent2.example.com:2380',
  'agent3.example.com=http://agent3.example.com:2380'
]

node etcd_cluster_member {
  class { 'etcd':
    listen_peer_urls            => ["http://${fqdn}:2380"],
    listen_client_urls          => ['http://0.0.0.0:2379'],
    advertise_client_urls       => ["http://${fqdn}:2379"],

    initial_advertise_peer_urls => ["http://${fqdn}:2380"],
    initial_cluster_state       => 'new',
    initial_cluster_token       => 'cluster231444',
    initial_cluster             => $etcdcluster,

    # Manage the Debian service file to ensure we log everything to syslog
    manage_service_file         => true
  }
}

node etcd_cluster_proxy {
  class { 'etcd':
    proxy                 => 'on',
    listen_client_urls    => ['http://localhost:2379'],
    advertise_client_urls => [''],

    initial_cluster       => $etcdcluster,

    # Manage the Debian service file to ensure we log everything to syslog
    manage_service_file   => true
  }
}

# etcd nodes
node /agent1.example.com/ inherits etcd_cluster_member {}
node /agent2.example.com/ inherits etcd_cluster_member {}
node /agent3.example.com/ inherits etcd_cluster_member {}

# etcd proxies
node /agent4.example.com/ inherits etcd_cluster_proxy {}
node /agent5.example.com/ inherits etcd_cluster_proxy {}
node /agent6.example.com/ inherits etcd_cluster_proxy {}
node /agent7.example.com/ inherits etcd_cluster_proxy {}
node /agent8.example.com/ inherits etcd_cluster_proxy {}
node /agent9.example.com/ inherits etcd_cluster_proxy {}
```
