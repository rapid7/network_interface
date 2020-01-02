require "spec_helper"

module NetworkInterface
  RSpec.describe Finder, type: :service do
    describe "class_methods" do
      context ".first" do
        subject { described_class.find.first }
        it "should return first ip in netework adress list" do
          expect(subject).to be_ipv4?
        end
      end
    end
    context ".find" do
      subject { described_class.find }
      describe "with no arguments" do
        it "should return all ipv4 addresses" do
          subject.each do |address|
            expect(address).to be_ipv4?
          end
        end
      end
      describe "with valid arguments" do
        block = -> address { address.ipv6? && !address.local? && !address.addr.nil? }
        let(:test) { described_class.find(&block) }
        it {
          test.each do |address|
            expect(address).to be_ipv6?
          end
        }
      end
      describe "with invalid arguments" do
        let(:query) { -> address { address.include? "foo" } }
        let(:test2) { described_class.find(&query) }
        it "should return empty array" do
          expect(test2).to be_empty
        end
      end
    end
  end
end
