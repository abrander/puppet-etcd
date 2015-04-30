# == Class etcd::params
#
class etcd::params {
  # Handle OS Specific config values
  case $::osfamily {
    'Redhat' : {
      $etcd_binary_location     = '/usr/sbin/etcd'
      $etcd_manage_service_file = true
      $etcd_manage_user         = true
      $etcd_manage_data_dir     = true
      $etcd_manage_log_dir      = true
    }
    'Debian' : {
      $etcd_binary_location     = '/usr/bin/etcd'
      $etcd_manage_service_file = false
      $etcd_manage_user         = false
      $etcd_manage_data_dir     = false
      $etcd_manage_log_dir      = false
    }
    default  : { fail("Unsupported osfamily ${::osfamily}") }
  }

  # Service settings
  $etcd_service_ensure          = 'running'
  $etcd_service_enable          = true

  # Package settings
  $etcd_package_ensure          = 'installed'
  $etcd_package_name            = 'etcd'

  # User settings
  $etcd_user                    = 'etcd'
  $etcd_group                   = 'etcd'

  # Data Dir
  $etcd_data_dir                = '/var/lib/etcd'

  # Log Dir
  $etcd_log_dir                 = '/var/log/etcd'

  $etcd_initial_advertise_peer_urls = ['http://localhost:2380', 'http://localhost:7001']
  $etcd_initial_cluster             = ['default=http://localhost:2380', 'default=http://localhost:7001']
  $etcd_initial_cluster_state       = 'new'
  $etcd_initial_cluster_token       = 'etcd-cluster'
  $etcd_advertise_client_urls       = ['http://localhost:2379', 'http://localhost:4001']
  $etcd_listen_peer_urls            = ['http://localhost:2380', 'http://localhost:7001']
  $etcd_listen_client_urls          = ['http://localhost:2379', 'http://localhost:4001']
  $etcd_proxy = 'off'

  # Node settings
  $etcd_node_name               = $::fqdn
  $etcd_addr                    = "${::fqdn}:4001"
  $etcd_bind_addr               = $etcd_addr
  $etcd_ca_file                 = ''
  $etcd_cert_file               = ''
  $etcd_key_file                = ''
  $etcd_cors                    = []
  $etcd_cpu_profile_file        = ''

  # Discovery support
  $etcd_discovery               = false
  $etcd_discovery_endpoint      = 'https://discovery.etcd.io/'
  $etcd_discovery_token         = ''
  $etcd_discovery_fallback      = 'proxy'
  $etcd_discovery_srv           = ''
  $etcd_discovery_proxy         = ''

  # Peer settings
  $etcd_peer_addr               = "${::fqdn}:7001"
  $etcd_peer_bind_addr          = $etcd_peer_addr
  $etcd_peers                   = []
  $etcd_peers_file              = undef
  $etcd_peer_ca_file            = ''
  $etcd_peer_cert_File          = ''
  $etcd_peer_key_file           = ''
  $etcd_peer_election_timeout   = '200'
  $etcd_peer_heartbeat_interval = '50'

  # Logging settings
  $etcd_verbose                 = false
  $etcd_very_verbose            = false

  # Snapshot settings
  $etcd_snapshot                = true
  $etcd_snapshot_count          = '10000'

  # Tuning settings
  $etcd_max_result_buffer       = '1024'
  $etcd_max_retry_attempts      = '3'

  # Cluster settings
  $etcd_cluster_active_size     = false
  $etcd_cluster_remove_delay    = '1800.0'
  $etcd_cluster_sync_interval   = '5.0'
}
