require 'spec_helper'

module Typekitable
  describe Tokenizer do
    subject { described_class }
    let(:token_store) { double(:file) }
    let(:example_token) { "4d6141e7c82cb30affebcc392abc2ce3ab0ea4c1" }

    context "#store" do
      it "stores a given API token" do
        expect(File).to receive(:open).with(Tokenizer::TOKEN_STORE, 'w').and_yield(token_store)
        expect(token_store).to receive(:write).with(example_token)

        subject.store(example_token)
      end
    end

    context "#has_token?" do
      it "returns true when a token file exists" do
        expect(File).to receive(:exist?).with(Tokenizer::TOKEN_STORE).and_return(true)

        expect(subject.has_token?).to be_truthy
      end

      it "returns false when a token file does not exist" do
        expect(File).to receive(:exist?).with(Tokenizer::TOKEN_STORE).and_return(false)

        expect(subject.has_token?).to be_falsey
      end
    end

    context "#get_token" do
      it "returns the token when one exists" do
        allow(subject).to receive(:has_token?).and_return(true)
        expect(File).to receive(:open).with(Tokenizer::TOKEN_STORE, 'r').and_yield(token_store)
        expect(token_store).to receive(:gets).and_return(example_token)

        expect(subject.get_token).to eq(example_token)
      end

      it "returns nil when the token does not exist" do
        allow(subject).to receive(:has_token?).and_return(false)

        expect(subject.get_token).to be_nil
      end
    end
  end
end
