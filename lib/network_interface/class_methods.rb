require_relative 'finder'

module NetworkInterface
  module ClassMethods
    def self.included(base)
      base.extend(ClassMethods)
    end

    def filter(q:)
      query = -> address { address.include? q }
      finder.find(&query)
    end

    private

    def finder
      Finder
    end
  end
end
