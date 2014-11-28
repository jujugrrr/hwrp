class Chef
  class Provider
    class MysqlClient
      class Connector < Chef::Provider::MysqlClient

        def load_current_resource
          @current_resource = Chef::Resource::Package.new(@new_resource.name)
        end

        def action_create
          Chef::Log.info("Creating mysql_client from Connector! Name : #{new_resource.name}")
        end

        def action_connect
          Chef::Log.info("Connection -#{new_resource.name}- with -#{newresource.connect}-")
        end

      end
   end
  end
end

Chef::Platform.set :platform => :centos, :resource => :mysql_client,
                     :provider => Chef::Provider::MysqlClient::Connector
