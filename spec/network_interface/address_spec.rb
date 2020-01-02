require "spec_helper"

module NetworkInterfaces
  RSpec.describe Address, type: :service do
    subject { described_class.call(hash) }

    context "is .ipv4" do
      let(:hash) {
        { 'name' => "en0", 'addr' => "192.168.1.123", 'netmask' => "255.255.255.0", 'peer' => nil }
      }
      it { expect(subject.ipv4?).to eq true }
    end
    context "is .ipv6" do
      let(:hash) {
        { 'name' => "en0", 'addr' => "fd29:b63d:14f0:d9e2:0000:0000:0000:0000", 'netmask' => "ffff:ffff:ffff:ffff::", 'peer' => nil }
      }
      it { expect(subject.ipv6?).to eq true }
    end
  end
end
