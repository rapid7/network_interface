# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'network_interface/version'

Gem::Specification.new do |spec|
  spec.name          = "network_interface"
  spec.version       = NetworkInterface::VERSION
  spec.authors       = ["Brandon Turner", "Lance Sanchez"]
  spec.email         = ["lance.sanchez@rapid7.com"]
  spec.description   = "Moving the netifaces from metasploit framework into its own gem"
  spec.summary       = "Moving the netifaces from metasploit framework into its own gem"
  spec.homepage      = ""
  spec.license       = "MIT"
  
  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rake-compiler", ">= 0"
end
