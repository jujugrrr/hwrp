class Chef
  class Resource
    class ExtendedMysqlServiceSlave < Chef::Resource::MysqlService
      # Chef attributes
      provides :extended_mysql_service_slave

      # Set the resource name
      self.resource_name = :extended_mysql_service_slave

      # Attributes
      attribute :connect, :kind_of => String, :default => nil
      attribute :server_type, :kind_of => String, :default => 'master'

    end
  end
end
