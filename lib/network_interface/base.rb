require 'network_interface'
require_relative 'address'

module NetworkInterfaces
  class Base
    def self.call
      new.call
    end

    def call
      network_addresses.flatten
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

    def network_interfaces
      network_interfaces ||= network_interface.interfaces
    end

    def network_interface
      ::NetworkInterface
    end
  end
end
