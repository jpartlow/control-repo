#!/opt/puppetlabs/puppet/bin/ruby

require 'json'
require 'socket'

#Get Hostname of puppetmaster
compile_master = Socket.gethostname
environmentpath = ARGV[0]
environment = ARGV[1]

#output the sha1 from the control-repo
r10k_deploy_file_path = File.join(environmentpath, environment, '.r10k-deploy.json')
commit_sha = JSON.parse(File.read(r10k_deploy_file_path))['signature']

hieradata_file_path = File.join(environmentpath, 'hieradata', '.r10k-deploy.json')
hiera_sha = JSON.parse(File.read(hieradata_file_path))['signature']

#ouput config version
puts "#{compile_master}/#{environment}::#{commit_sha[0...7]}/hieradata::#{hiera_sha[0...7]}"
