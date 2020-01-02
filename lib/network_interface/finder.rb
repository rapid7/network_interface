require_relative 'base'

module NetworkInterface
  class Finder
    def self.find(*args, &block)
      block = -> address { address.ipv4? && !address.local? && !address.blank? } unless block_given?
      ::NetworkInterfaces::Base.call.select(*args, &block)
    end
  end
end
