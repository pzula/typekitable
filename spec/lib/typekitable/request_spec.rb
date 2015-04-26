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
      context "successful response" do
        it "returns the request response with access to the code, message, and body" do
          VCR.use_cassette 'kits' do
            allow(subject).to receive(:token).and_return(token)
            @response = subject.response
          end

          expected_code = "200"
          expected_message = "OK"
          expected_body = "{\"kits\":[{\"id\":\"yuw0tqs\",\"link\":\"/api/v1/json/kits/yuw0tqs\"}]}"
          expect(@response.body).to eq(expected_body)
          expect(@response.code).to eq(expected_code)
          expect(@response.message).to eq(expected_message)
        end
      end

      context "unsuccessful response" do
        let(:token) { "143250b7c5b996b2fb5e65ee4a6b870b9bd3297" }

        it "returns the request response with access to the code, message, and body" do

          VCR.use_cassette 'kits_error' do
            allow(subject).to receive(:token).and_return(token)
            @response = subject.response
          end

          expected_code = "401"
          expected_message = "Unauthorized"
          expected_body = "{\"errors\":[\"Not authorized\"]}"
          expect(@response.body).to eq(expected_body)
          expect(@response.code).to eq(expected_code)
          expect(@response.message).to eq(expected_message)
        end
      end
    end
  end
end
