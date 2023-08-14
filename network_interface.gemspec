# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'network_interface/version'

Gem::Specification.new do |spec|
  spec.name          = "network_interface"
  spec.version       = NetworkInterface::VERSION
  spec.authors       = ["Brandon Turner", "Lance Sanchez"]
  spec.email         = ["lance.sanchez@rapid7.com", "brandon_turner@rapid7.com"]
  spec.summary       = "A cross platform gem to help get network interface information"
  spec.description   = %q{
     This gem was originally added to the Metasploit Pcaprub gem. It's been spun
     out into its own gem for anyone who might want to programmatically get
     information on their network interfaces. }
  spec.homepage      = "https://github.com/rapid7/network_interface"
  spec.license       = "MIT"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features|tmp)/}) }
  end
  spec.extensions    = ['ext/network_interface_ext/extconf.rb']
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "rake"
  spec.add_development_dependency "rake-compiler"
  spec.add_development_dependency "rspec"
end
