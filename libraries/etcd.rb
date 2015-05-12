# Encoding: UTF-8
#
# Etcd Helper Libraries
#
#
class Chef
  class Recipe
    # Recipe helpers for etcd cookbook
    module Etcd
      class << self
        attr_accessor :slave, :node

        # return cmd args for discovery/cluster members
        def discovery_cmd
          cmd = ''
          discovery = node[:etcd][:discovery]
          unless discovery.empty?
            cmd << " -discovery='#{discovery}'"
          end
          cmd
        end

        def lookup_addr(option, key, ports)
          cmd = ''
          val = node[:etcd][key.to_sym]
          unless val.empty?
            cmd << " #{option}=#{val}"
          else
            cmd << " #{option}=#{node[:etcd][:http_protocol]}#{node[:ipaddress]}:#{ports[0]},#{node[:etcd][:http_protocol]}#{node[:ipaddress]}:#{ports[1]}"
          end
          cmd
        end

        def cluster_args
          cmd = ''
          node[:etcd][:cluster].each do | arg, value |
            cmd << " --#{arg.gsub('_', '-')}=#{value}" if value.match(/.*:(\d)/)
          end
          cmd
        end

        # when you specify args in config we don't compute. so you have to specify all of them
        #
        def args
          cmd = node[:etcd][:args].dup
          cmd << " -name #{node[:etcd][:name]}" unless node[:etcd][:name].empty?
          cmd << discovery_cmd
          cmd << lookup_addr('--listen-peer-urls', :listen_peer_urls, [2380, 7001])
          cmd << lookup_addr('--listen-client-urls', :listen_client_urls, [2379, 4001])
          cmd << cluster_args
          cmd
        end
        # rubocop:endable MethodLength

        #
        # compute the package name based on etcd version
        #
        def package_name
          version = node[:etcd][:version]
          fail ArgumentError, 'need to specify a version for etcd' unless version
          if Gem::Requirement.new('>= 0.3.0').satisfied_by?(Gem::Version.new(version))
            "etcd-v#{version}-#{node[:os]}-amd64.tar.gz"
          else
            "etcd-v#{version}-#{node[:os].capitalize}-x86_64.tar.gz"
          end
        end

        #
        # Return URL for package via what user has supplied of what we compute
        #
        def bin_url
          version = node[:etcd][:version]
          if node[:etcd][:url]
            node[:etcd][:url]
          else
            "https://github.com/coreos/etcd/releases/download/v#{version}/#{package_name}"
          end
        end
      end
    end
  end
end
