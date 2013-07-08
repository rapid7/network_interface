$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), 'lib'))
require 'network_interface'
require 'rspec'
require 'rspec/autorun'

RSpec.configure do |config|
end

if RUBY_PLATFORM =~ /i386-mingw32/
  def system_interfaces
    ipconfig = `ipconfig`
    ipconfig_array = ipconfig.split("\n").select {|s| !s.empty?}
    interfaces = {}
    @key = nil
    ipconfig_array.each do |element|
      if element.start_with? " "
        case element
        when /IPv6 Address.*:(.*)/
          interfaces[@key][:ipv6] = $1
        when /IPv4 Address.*:(.*)/
          interfaces[@key][:ipv4] = $1
        end
      elsif element[/Windows IP Configuration/]
      elsif element[/Ethernet adapter (.*):/]
        @key = $1
        interfaces[@key] = {}
      else
        @key = element[/(.*):/,1]
        interfaces[@key] = {}
      end
    end
    interfaces
  end

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