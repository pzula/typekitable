require 'spec_helper'

module Typekitable
  describe Request do
    let(:path) { "kits" }
    let(:verb) { "GET" }
    let(:parameters) { {} }
    let(:token) { "5e4ce50b7c5b996b2fb5e65ee4a6b870b9bd3297" }

    subject { described_class.new(path, verb, parameters) }

    context ".new" do
      it "stores the path" do
        expect(subject.verb).to eq(verb)
      end

      it "stores the verb" do
        expect(subject.path).to eq(path)
      end

      it "stores the parameters" do
        expect(subject.parameters).to eq(parameters)
      end
    end

    context ".token" do
      it "returns the token" do
        expect(Tokenizer).to receive(:get_token).and_return(token)

        subject.token
      end
    end

    context ".response" do
      context "get kit list" do
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

      context "get libraries list" do
        let(:path) { "libraries" }
        let(:verb) { "GET" }
        context "successful response" do
          it "returns the request response with access to the code, message, and body" do
            VCR.use_cassette 'libraries' do
              allow(subject).to receive(:token).and_return(token)
              @response = subject.response
            end

            expected_code = "200"
            expected_message = "OK"
            expected_body = "{\"libraries\":[{\"id\":\"trial\",\"link\":\"/api/v1/json/libraries/trial\",\"name\":\"Trial Library\"},{\"id\":\"personal\",\"link\":\"/api/v1/json/libraries/personal\",\"name\":\"Personal Library\"},{\"id\":\"full\",\"link\":\"/api/v1/json/libraries/full\",\"name\":\"Full Library\"}]}"
            expect(@response.body).to eq(expected_body)
            expect(@response.code).to eq(expected_code)
            expect(@response.message).to eq(expected_message)
          end
        end
      end

      context "post new kit" do
        let(:path) { "kits" }
        let(:verb) { "POST" }
        let(:parameters) { {:name => "A new kit", :domains => "http://persazula.com"} }

        context "successful response" do
          it "returns the request response with access to the code, message, and body" do
            VCR.use_cassette 'add_kit' do
              allow(subject).to receive(:token).and_return(token)
              @response = subject.response
            end

            expected_code = "200"
            expected_message = "OK"
            expected_body = "{\"kit\":{\"id\":\"fla3cfh\",\"name\":\"A new kit\",\"analytics\":false,\"domains\":[\"persazula.com\"],\"families\":[]}}"
            expect(@response.body).to eq(expected_body)
            expect(@response.code).to eq(expected_code)
            expect(@response.message).to eq(expected_message)
          end
        end

        context "unauthorized response" do
          let(:token) { "143250b7c5b996b2fb5e65ee4a6b870b9bd3297" }

          it "returns the request response with access to the code, message, and body" do

            VCR.use_cassette 'add_kit_unauthorized_error' do
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

        context "maximum kits response" do
          it "returns the request response with access to the code, message, and body" do

            VCR.use_cassette 'add_kit_maximum_error' do
              allow(subject).to receive(:token).and_return(token)
              @response = subject.response
            end

            expected_code = "400"
            expected_message = "Bad Request"
            expected_body = "{\"errors\":[\"You have reached the maximum number of kits\"]}"
            expect(@response.body).to eq(expected_body)
            expect(@response.code).to eq(expected_code)
            expect(@response.message).to eq(expected_message)
          end
        end
      end
    end
  end
end
