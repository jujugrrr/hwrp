# Encoding: utf-8
#
# Cookbook Name:: mysql2
# Recipe:: default
#
# Copyright 2014, Rackspace
#

log 'YEEAAAHHHHH'

mysql_client 'MY CLIENT' do
#  connect '8.8.8.8'
  action :create
#  provider Chef::Provider::MysqlClient::Connector
end
