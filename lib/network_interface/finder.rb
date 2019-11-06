require 'network_interface'
require_relative 'address'

module NetworkInterface
  class Finder
    def self.first
      new.call.first
    end

    def self.find(&block)
      new.call.select(&block)
    end

    def call
      network_addresses_array = network_addresses.flatten
      find(network_addresses_array)
    end

    private

    def network_addresses
      network_interfaces.collect do |interface|
        values = network_interface.addresses(interface).values
        values.map do |value|
          hash = Hash["name" => interface].merge(*value)
          ::NetworkInterfaces::Address.call(hash)
        end
      end
    end

    def find(arry)
      arry.select{ |value| value.ipv4? && !value.local? }
    end

    def network_interfaces
      network_interfaces ||= network_interface.interfaces
    end

    def network_interface
      ::NetworkInterface
    end
  end
end
