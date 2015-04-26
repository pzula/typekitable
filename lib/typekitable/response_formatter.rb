module Typekitable
  class ResponseFormatter
    attr_reader :response

    ERRORS = {
      "400" => "Error in data sent",
      "401" => "Not authorized",
      "403" => "Rate limit reached",
      "404" => "Not found",
      "500" => "Unable to process request",
      "503" => "Service is offline"
    }

    def initialize(response)
      @response = response
    end

    def error?
      ERRORS.keys.include?(response.code)
    end

    def parsed_body
      JSON.parse(response.body, :symbolize_names => true)
    end

    def table_headers
      if error?
        error_key
      elsif collection?
        collection_headers
      elsif singular_resource?
        singular_resource_headers
      else
        [parsed_body.first]
      end
    end

    def table_body
      if error?
        error_message
      elsif collection?
        collection_data
      elsif singular_resource?
        singular_resource_data
      else
        empty_response_data
      end
    end

    def data_heading
      main_key.to_s.capitalize
    end

    def output_heading
      display_line(data_heading)
    end

    def output_body
      display_table(table_body, table_headers)
    end

    private

    def data_element
      parsed_body[main_key]
    end

    def singular_resource?
      !error? && data_element.is_a?(Hash)
    end

    def collection?
      !error? && data_element.is_a?(Array)
    end

    def empty_response?
      data_element.any?
    end

    def main_key
      parsed_body.keys.first
    end

    def collection_headers
      data_element.map do |data|
        data.keys
      end.flatten.uniq
    end

    def collection_data
      data_element.map do |line|
        line
      end
    end

    def singular_resource_headers
      data_element.keys
    end

    def singular_resource_data
      [data_element]
    end

    def empty_response_data
      [{ main_key => "Nothing to show" }]
    end

    def error_key
      [response.code]
    end

    def error_message
      [{response.code => data_element.pop}]
    end

    def display_line(line)
      Formatador.display_line(line)
    end

    def display_table(table_data, headers)
      Formatador.display_table(table_data, headers)
    end
  end
end
