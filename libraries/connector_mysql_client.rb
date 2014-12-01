class Chef
  class Resource
    class ExtendedMysqlService < Chef::Resource::MysqlService
      # Chef attributes
      provides :extended_mysql_service

      # Set the resource name
      self.resource_name = :extended_mysql_service

      # Attributes
      attribute :connect, :kind_of => String, :default => nil
      attribute :server_type, :kind_of => String, :default => 'master'

    end
  end
end

class Chef
  class Provider
    class ExtendedMysqlService
      class Rhel < Chef::Provider::MysqlService::Rhel
        def action_create
          super
          if new_resource.connect && new_resource.server_type == 'slave'
            ExtendedMysql.connect_to_master(new_resource)
          end
        end
      end
    end
  end
end

module ExtendedMysql
  def ExtendedMysql.connect_to_master(new_resource)
    Chef::Log.info("Connecting Mysql slave instance: ==#{new_resource.name}== to Mysql master instance: ==#{new_resource.connect}==")

    # drop MySQL slave specific configuration file
    template '/etc/mysql/conf.d/slave.cnf' do
      notifies :restart, "mysql_service[#{new_resource.service_name}]", :delayed
    end
    # Connect slave to master MySQL server
    execute 'change master' do
      command <<-EOH
      /usr/bin/mysql -u root -p'#{new_resource.server_root_password}' < /root/change.master.sql
      rm -f /root/change.master.sql
      EOH
      action :nothing
    end
    template '/root/change.master.sql' do
      path '/root/change.master.sql'
      owner 'root'
      group 'root'
      mode '0600'
      variables(
        host: new_resource.connect,
        user: 'repl',
        password: new_resource.server_repl_password
      )
      notifies :run, 'execute[change master]', :immediately
    end
  end
end


Chef::Platform.set :platform => :centos, :resource => :extended_mysql_service, :provider => Chef::Provider::ExtendedMysqlService::Rhel
