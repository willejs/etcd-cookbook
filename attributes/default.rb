# Encoding: UTF-8
default[:etcd][:install_method] = 'binary'

# the default http protocol to use 
default[:etcd][:http_protocol] = 'http://'

# address to announce to peers specified as ip:port or ip (will default to :7001)
default[:etcd][:listen_peer_urls] = ''

# address to announce to clients specified as ip:port or ip (will default to :7001)
default[:etcd][:listen_client_urls] = ''

# set if you want to override the node name. It uses fqdn by default
default[:etcd][:name] = ''

# if you wrap this cookbook you should use your wrappers cook name here
default[:etcd][:search_cook] = 'etcd\:\:cluster'

# set to false if you don't want environment scoped searching
default[:etcd][:env_scope] = true

# service start args to pass
default[:etcd][:args] = ''

# v2.0.0 API cluster discovery
default[:etcd][:discovery] = ''

# Clustering flags. set any of these and they are included

# List of URLs to listen on for peer traffic. if not set we compute it to http://localhost:2380,http://localhost:7001
default[:etcd][:cluster][:initial_advertise_peer_urls] = ''

# Initial cluster configuration for bootstrapping
default[:etcd][:cluster][:initial_cluster] = ''

# Initial cluster state ("new" or "existing").
default[:etcd][:cluster][:initial_cluster_state] = 'new'

# Initial cluster token for the etcd cluster during bootstrap.
default[:etcd][:cluster][:initial_cluster_token] = ''

# List of URLs to listen on for client traffic. if not set we compute it to http://#{node['opaddress']}:2379,http://#{node['opaddress']}:4001
default[:etcd][:cluster][:advertise_client_urls] = ''

# Discovery URL used to bootstrap the cluster.
default[:etcd][:cluster][:discovery] = ''

# DNS srv domain used to bootstrap the cluster.
default[:etcd][:cluster][:discovery_srv] = ''

# Expected behavior ("exit" or "proxy") when discovery services fails.
default[:etcd][:cluster][:discovery_fallback] = ''

# HTTP proxy to use for traffic to discovery service.
default[:etcd][:cluster][:discovery_proxy] = ''

# restart etcd when the config file is updated
default[:etcd][:trigger_restart] = true

# start etcd when etcd is first installed
default[:etcd][:trigger_start] = true

# Upstart parameters for starting/stopping etcd service
default[:etcd][:upstart][:start_on] = 'started networking'
default[:etcd][:upstart][:stop_on] = 'shutdown'

# Release to install
default[:etcd][:version] = '2.0.10'

# Auto respawn
default[:etcd][:respawn] = false

# Sha for github tarball Linux by default
default[:etcd][:sha256] = 'c597cb3684b9304ae86f0e3145204c75cf4720080bfecb796a8980044f7a45c3'

# Use this to supply your own url to a tarball
default[:etcd][:url] = nil

# Etcd's backend storage
default[:etcd][:state_dir] = '/var/cache/etcd/state'

# Used for source_install method
default[:etcd][:source][:repo] = 'https://github.com/coreos/etcd'
default[:etcd][:source][:revision] = 'HEAD'
default[:etcd][:source][:go_ver] = '1.1.2'
default[:etcd][:source][:go_url] = ''
default[:etcdctl][:source][:repo] = 'https://github.com/coreos/etcdctl'
default[:etcdctl][:source][:revision] = 'HEAD'

# Create user and group for etcd
default[:etcd][:user] = 'etcd'
default[:etcd][:group] = 'etcd'

# Set etcd log dir & file
default[:etcd][:log_to_file] = false
default[:etcd][:log_dir] = '/var/log/etcd'
default[:etcd][:log_file] = 'etcd.log'
