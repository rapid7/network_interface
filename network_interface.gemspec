# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'network_interface/version'

Gem::Specification.new do |spec|
  spec.name          = "network_interface"
  spec.version       = NetworkInterface::VERSION
  spec.authors       = ["Brandon Turner", "Lance Sanchez"]
  spec.email         = ["lance.sanchez@rapid7.com"]
  spec.summary       = "A cross platform gem to help get interface information"
  spec.description   = "This gem was originally added to the Metasploit Pcaprub gem. I have spun this out into its own gem for anyone who might want to programmatically get information on their network interfaces"
  spec.homepage      = "https://github.com/rapid7/network_interface"
  spec.license       = "MIT"
  
  spec.files         = `git ls-files`.split($/)
  spec.extensions    = ['ext/network_interface_ext/extconf.rb']
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rake-compiler", ">= 0"
  spec.add_development_dependency "rspec"
end
