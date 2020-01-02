require 'rspec/expectations'

RSpec::Matchers.define :be_ipv6? do |expected|
  match do |actual|
    begin
      IPAddr.new(actual.addr).ipv6?
    rescue IPAddr::InvalidAddressError => e
      false
    end
  end
end

RSpec::Matchers.define :be_ipv4? do |expected|
  match do |actual|
    begin
      IPAddr.new(actual.addr).ipv4?
    rescue IPAddr::InvalidAddressError => e
      false
    end
  end
end

RSpec::Matchers.define :be_local? do |expected|
  match do |actual|
    actual.addr[/^127.*/]
  end
end
