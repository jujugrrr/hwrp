class Chef
  class Resource
    class ConnectorMysqlClient < Chef::Resource::MysqlClient
      # Chef attributes
      provides :connector_mysql_client

      # Set the resource name
      self.resource_name = :connector_mysql_client

      # Actions
      actions :create, :delete, :connect
      default_action :create

      # Attributes
      attribute :connect, :kind_of => String, :default => nil
    end
  end
end

#class Chef
#  class Provider
#    class ConnectorMysqlClient < Chef::Provider::MysqlClient
#
#        def load_current_resource
#          @current_resource = Chef::Resource::ConnectorMysqlClient.new(@new_resource.name)
#        end
##        def action_create
##          super
##          Chef::Log.info("Connection -#{new_resource.name}- with -#{new_resource.connect}-") if new_resource.connect
##        end
#
#    end
#  end
#end

class Chef
  class Provider
    class ConnectorMysqlClient
      class Rhel < Chef::Provider::MysqlClient::Rhel
        def action_create
          super
          Chef::Log.info("Connection -#{new_resource.name}- with -#{new_resource.connect}-") if new_resource.connect
        end
      end
    end
  end
end


#Chef::Platform.set :platform => :centos, :resource => :mysql_client,
#                     :provider => Chef::Provider::MysqlClient::Connector
Chef::Platform.set :platform => :centos, :resource => :connector_mysql_client, :provider => Chef::Provider::ConnectorMysqlClient::Rhel
