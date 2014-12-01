# Encoding: utf-8
#
# Cookbook Name:: mysql2
# Recipe:: default
#
# Copyright 2014, Rackspace
#

extended_mysql_service 'my_slave_1' do
  connect '8.8.8.8'
  server_repl_password 'repl_password'
  server_type 'slave'
  action :create
end
