require 'spec_helper'

module Typekitable
  describe Request do
    let(:path) { "kits" }
    let(:verb) { "GET" }
    let(:token) { "5e4ce50b7c5b996b2fb5e65ee4a6b870b9bd3297" }

    subject { described_class.new(path, verb) }

    context ".new" do
      it "stores the path" do
        expect(subject.verb).to eq(verb)
      end

      it "stores the verb" do
        expect(subject.path).to eq(path)
      end
    end

    context ".token" do
      it "returns the token" do
        expect(Tokenizer).to receive(:get_token).and_return(token)

        subject.token
      end
    end

    context ".response" do
      it "returns the request response" do
        VCR.use_cassette 'kits' do
          @response = subject.response
        end

        expected_response = "{\"kits\":[{\"id\":\"yuw0tqs\",\"link\":\"/api/v1/json/kits/yuw0tqs\"}]}"
        expect(@response).to eq(expected_response)
      end
    end
  end
end