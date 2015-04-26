require 'spec_helper'

module Typekitable
  describe ResponseFormatter do

    let(:success_response) do
      double(
        :response,
        :code => "200",
        :message => "OK",
        :body => "{\"kits\":[{\"id\":\"yuw0tqs\",\"link\":\"/api/v1/json/kits/yuw0tqs\"}]}"
      )
    end

    let(:successful_response_with_long_body) do
      double(
        :response,
        :code => "200",
        :message => "OK",
        :body => "{\"libraries\":[{\"id\":\"trial\",\"link\":\"/api/v1/json/libraries/trial\",\"name\":\"Trial Library\"},{\"id\":\"personal\",\"link\":\"/api/v1/json/libraries/personal\",\"name\":\"Personal Library\"},{\"id\":\"full\",\"link\":\"/api/v1/json/libraries/full\",\"name\":\"Full Library\"}]}"
      )
    end

    let(:singular_resource_response) do
      double(
        :response,
        :code => "200",
        :message => "OK",
        :body => "{\"kit\":{\"id\":\"fla3cfh\",\"name\":\"A new kit\",\"analytics\":false,\"domains\":[\"persazula.com\"],\"families\":[]}}"
      )
    end

    let(:short_response) do
      double(
        :response,
        :code => "200",
        :message => "OK",
        :body => "{\"published\":\"2015-04-26T23:35:33Z\"}"
      )
    end

    let(:empty_response) do
      double(
        :response,
        :code => "200",
        :message => "OK",
        :body => "{\"kits\":[{}]}"
      )
    end

    let(:error_response) do
      double(
        :response,
        :code => "401",
        :message => "Unauthorized",
        :body => "{\"errors\":[\"Not authorized\"]}"
      )
    end

    context ".error" do
      context "with successful response code" do
        subject { described_class.new(success_response) }

        it "returns false" do
          expect(subject.error?).to be_falsey
        end
      end

      context "with unsuccessful response code" do
        subject { described_class.new(error_response) }

        it "returns false" do
          expect(subject.error?).to be_truthy
        end
      end
    end

    context ".parsed_body" do
      context "success response" do
        subject { described_class.new(success_response) }

        it "formats the body to a usable hash structure" do
          expect(subject.parsed_body).to eq({:kits => [{:id =>"yuw0tqs", :link =>"/api/v1/json/kits/yuw0tqs"}]})
        end
      end

      context "error response" do
        subject { described_class.new(error_response) }

        it "formats the body to a usable hash structure" do
          expect(subject.parsed_body).to eq({:errors => ["Not authorized"]})
        end
      end
    end

    context ".table_headers" do
      subject { described_class.new(successful_response_with_long_body) }

      it "formats the table headers for a collection" do
        expected_headers = [:id, :link, :name]

        expect(subject.table_headers).to eq(expected_headers)
      end

      it "formats the table headers for a singular resource" do
        singular_resource_subject = described_class.new(singular_resource_response)
        expected_headers = [:id, :name, :analytics, :domains, :families]

        expect(singular_resource_subject.table_headers).to eq(expected_headers)
      end

      it "formats the table header for a short message" do
        expected_header = [:published]

        expect(described_class.new(short_response).table_headers).to eq(expected_header)
      end

      it "formats the table headers for an empty response" do
        response = described_class.new(empty_response)
        expected_headers = []

        expect(response.table_headers).to eq(expected_headers)
      end

      it "formats the table header if an error response is detected" do
        error_subject = described_class.new(error_response)

        expect(error_subject.table_headers).to eq(["401"])
      end
    end

    context ".table_body" do
      subject { described_class.new(successful_response_with_long_body) }

      it "formats the table body for a collection" do
        expected_body = [
          {
            :id => "trial",
            :link => "/api/v1/json/libraries/trial",
            :name=> "Trial Library"
          },
          {
            :id => "personal",
            :link => "/api/v1/json/libraries/personal",
            :name => "Personal Library"
          },
          {
            :id => "full",
            :link => "/api/v1/json/libraries/full",
            :name => "Full Library"
          }
        ]
        expect(subject.table_body).to eq(expected_body)
      end

      it "formats the table body for errors" do
        error_subject = described_class.new(error_response)

        expect(error_subject.table_body).to eq([{"401"=>"Not authorized"}])
      end

      it "formats the table body for a singular resource" do
        singular_resource_subject = described_class.new(singular_resource_response)

        expected_body = [
          {
            :id => "fla3cfh",
            :name => "A new kit",
            :analytics => false,
            :domains => ["persazula.com"],
            :families => []
          }
        ]

        expect(singular_resource_subject.table_body).to eq(expected_body)
      end

      it "formats the table body for a short message" do
        expected_body = [{:published => "2015-04-26T23:35:33Z"}]

        expect(described_class.new(short_response).table_body).to eq(expected_body)
      end

      it "formats the table body when no data is received" do
        response = described_class.new(empty_response)

        expect(response.table_body).to eq([{}])
      end
    end

    context ".data_heading" do
      subject { described_class.new(successful_response_with_long_body) }

      it "formats the data heading for display" do
        expect(subject.data_heading).to eq("Libraries")
      end
    end
  end
end
