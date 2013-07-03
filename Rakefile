# require "bundler/gem_tasks"
require 'bundler'
Bundler::GemHelper.install_tasks

require 'rake/extensiontask'
Rake::ExtensionTask.new('network_interface_ext')

task :default => [:clean, :compile]