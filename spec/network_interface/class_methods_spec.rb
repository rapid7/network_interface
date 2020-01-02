require "spec_helper"

module NetworkInterface
  RSpec.describe ClassMethods, type: :service do
    let!(:fake_class) do
      module Foo
        include ::NetworkInterface::ClassMethods
      end
    end
    subject { fake_class.filter(q: argument) }

    describe "with valid arguments" do
      let(:argument) { "en0" }
      it { expect(subject).not_to be_nil }
    end
    describe "with invalid arguments" do
      let(:argument) { nil }
      it { expect(subject).to be_nil }
    end
  end
end
