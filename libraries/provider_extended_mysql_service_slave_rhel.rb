class Chef
  class Provider
    class ExtendedMysqlServiceSlave
      class Rhel < Chef::Provider::MysqlService::Rhel
        def action_create
          super
          use_inline_resources if defined?(use_inline_resources)
          Chef::Log.info("Connecting Mysql slave instance: ==#{new_resource.name}== to Mysql master instance: ==#{new_resource.connect}==")

          # XXX I had to redefine https://github.com/opscode-cookbooks/mysql/blob/master/libraries/provider_mysql_service_rhel.rb#L68-L71, because I was not able to notify it from here, probable because https://github.com/opscode-cookbooks/mysql/blob/master/libraries/provider_mysql_service_rhel.rb#L10 create a run_context inside Chef::Provider::MysqlService::Rhel but not inside Chef::Provider::ExtendedMysqlServiceSlave::Rhel
          service service_name do
            supports :restart => true
            action [:start, :enable]
          end

          # drop MySQL slave specific configuration file
          template '/etc/mysql/conf.d/slave.cnf' do
            notifies :restart, "service[#{service_name}]", :delayed
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
    end
  end
end
