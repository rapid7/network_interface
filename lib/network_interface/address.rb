module NetworkInterfaces
  class Address < Struct.new(:name, :addr, :netmask, :peer)
    def self.call(hash)
      new(hash["name"], hash["addr"], hash["netmask"], hash["peer"])
    end

    def ipv4?
      begin
        IPAddr.new(addr).ipv4?
      rescue IPAddr::InvalidAddressError => e
        false
      end
    end

    def local?
      addr[/^127.*/]
    end
  end
end
