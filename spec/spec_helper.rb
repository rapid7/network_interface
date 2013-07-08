$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), 'lib'))
require 'network_interface'
require 'rspec'
require 'rspec/autorun'

RSpec.configure do |config|
end

if RUBY_PLATFORM =~ /i386-mingw32/
  
else
  def system_interfaces
    ifconfig = `/sbin/ifconfig`
    ifconfig_array = ifconfig.split("\n")
    ifconfig_array.map!{|element| element.split("\n")}
    ifconfig_array.flatten!
    interfaces = {}
    @key = nil
    ifconfig_array.each do |element|
      if element.start_with? "\t"
        case element
        when /\tether (.*) /
          interfaces[@key][:mac] = $1
        when /\tinet6 (.*) prefixlen/
          interfaces[@key][:ipv6] = $1
        when /\inet (.*) netmask (.*) broadcast (.*)/
          interfaces[@key][:ipv4] = $1
          interfaces[@key][:netmask] = $2
          interfaces[@key][:broadcast] = $3
        end
      else
        @key = element.split(':').first
        interfaces[@key] = {}
      end
    end
    interfaces
  end
end

def system_interfaces_with_addresses
  interfaces = {}
  system_interfaces.each do |key, value|
    if value.has_key? :ipv4
      interfaces[key] = value
    end
  end
  interfaces
end