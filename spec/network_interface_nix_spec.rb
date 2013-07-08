require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe NetworkInterface do

  describe "#interfaces" do
    it "should not crash" do
      NetworkInterface.interfaces
    end
    it "should have the same interfaces as the system_interfaces" do
      NetworkInterface.interfaces.should include(*system_interfaces.keys)
    end
  end
  
  describe "#addresses" do
    it "should not crash" do
      NetworkInterface.addresses(NetworkInterface.interfaces.first)
    end
    
    system_interfaces_with_addresses.each do |interface, hash|
      describe "#{interface}" do
        if hash.has_key?(:ipv4)
          describe "ipv4" do
            it "should have an ipv4 address" do
              NetworkInterface.addresses(interface).should have_key NetworkInterface::AF_INET
            end
            it "should match the system interface" do
              NetworkInterface.addresses(interface)[NetworkInterface::AF_INET][0]["addr"].should == hash[:ipv4]
            end
          end
        end
        if hash.has_key?(:ipv6)
          describe "ipv6" do
            it "should have an ipv6 address" do
              NetworkInterface.addresses(interface).should have_key NetworkInterface::AF_INET6
            end
            it "should match the system interface" do
              NetworkInterface.addresses(interface)[NetworkInterface::AF_INET6][0]["addr"].should == hash[:ipv6]
            end
          end          
        end
        
      end
    end
    
  end
end