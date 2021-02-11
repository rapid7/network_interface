require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe NetworkInterface do

  describe "#interfaces" do
    it "should have the same interfaces as the system_interfaces" do
      expect(NetworkInterface.interfaces).to include(*system_interfaces_with_addresses.keys)
    end
  end
  
  describe "#addresses" do
    system_interfaces_with_addresses.each do |interface, hash|
      describe "#{friendly_interface_names.key(interface)}" do
        if hash.has_key?(:ipv4)
          describe "ipv4" do
            it "should have an ipv4 address" do
              expect(NetworkInterface.addresses(interface)).to have_key NetworkInterface::AF_INET
            end
            it "should match the system interface of #{hash[:ipv4]}" do
              expect(NetworkInterface.addresses(interface)[NetworkInterface::AF_INET][0]["addr"]).to eq hash[:ipv4]
            end
          end
        end
        if hash.has_key?(:ipv6)
          describe "ipv6" do
            it "should have an ipv6 address" do
              expect(NetworkInterface.addresses(interface)).to have_key NetworkInterface::AF_INET6
            end
            it "should match the system interface of #{hash[:ipv6]}" do
              expect(NetworkInterface.addresses(interface)[NetworkInterface::AF_INET6][0]["addr"]).to eq hash[:ipv6]
            end
          end          
        end
        if hash.has_key?(:mac)
          describe "MAC address" do
            it "should have a MAC address" do
              expect(NetworkInterface.addresses(interface)).to have_key NetworkInterface::AF_LINK
            end
            it "should match the system interface of #{hash[:mac]}" do
              expect(NetworkInterface.addresses(interface)[NetworkInterface::AF_LINK][0]["addr"]).to eq hash[:mac]
            end
          end
        end
      end
    end
    
  end
end
