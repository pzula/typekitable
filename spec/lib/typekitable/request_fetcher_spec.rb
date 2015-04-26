require 'spec_helper'

module Typekitable
  describe RequestFetcher do
    subject { described_class.new(:kit_list) }
    let(:type) { :kit_list }
    let(:path) { "kits" }
    let(:verb) { "GET" }
    let(:response) { double(:response) }
    let(:request) { double(:request, :response => response) }

    context ".new" do
      it "stores a type if the type is valid" do
        expect(type).to eq(type)
      end

      it "raises an error if the type is invalid" do
        invalid_type = :invalid

        expect{described_class.new(invalid_type)}.to raise_error(InvalidTypeError)
      end
    end

    context ".request_path" do
      it "returns the request path for type" do
        expect(subject.request_path).to eq(path)
      end
    end

    context ".verb" do
      it "returns the verb for type" do
        expect(subject.verb).to eq(verb)
      end
    end

    context ".response" do
      it "sends for the response" do
        expect(Request).to receive(:new).with(path, verb).and_return(request)
        expect(request).to receive(:response).and_return(response)

        subject.response
      end
    end
  end
end
