require 'spec_helper'

module Typekitable
  describe Commander do
    subject { described_class }
    let(:authenticator) { double(:authenticator) }

    context ".re_authenticate" do
      it "gets the result of re-authenticating" do
        expect(Authenticator).to receive(:new).and_return(authenticator)
        expect(authenticator).to receive(:get_authentication).and_return(true)

        subject.start(%w(re-authenticate))
      end
    end
  end
end
