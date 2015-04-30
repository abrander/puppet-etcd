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
-----------
It assumes you have a package available called etcd. If you don't have one
[go make one](https://github.com/solarkennedy/etcd-packages)

Contact
-------
Kyle Anderson <kyle@xkyle.com>

Support
-------
Please log tickets and issues on [GitHub](https://github.com/solarkennedy/puppet-etcd/issues)
