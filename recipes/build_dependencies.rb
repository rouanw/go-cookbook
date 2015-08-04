# Cookbook Name:: go
# Recipe:: build_dependencies

include_recipe "nodejs"
include_recipe "maven"
include_recipe "build-essential"
include_recipe "subversion"
package "gnuplot"
