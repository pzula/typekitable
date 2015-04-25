require 'spec_helper'

module Typekitable
  describe Authenticator do
    let(:subject) { described_class.new }

    context ".get_authentication" do
      xit "asks the user if they have an API token" do
        expect(subject).to receive(:readline).with("Do you have a Typekit API token? [y/N]", {}).and_return("n")

        goodbye = capture(:stdout) { subject.get_authentication }
        expect(goodbye).to eq("Generate an API token at https://typekit.com/account/tokens and come back once you have it, we will only ask for it once")
      end

      xit "provides information on where to obtain a API token when user does not have one" do
      end

      xit "requests the user's API token" do
      end
    end
  end
end
