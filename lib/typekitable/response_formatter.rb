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

    def data_heading
      parsed_body.map {|key, _| key}.pop.to_s.capitalize
    end

    def table_headers
      return error_key if error?
      parsed_body.map do |index, data|
        data[0].keys.map do |key|
          key
        end
      end.flatten
    end

    def table_body
      return error_message if error?
      parsed_body.map do |index, data|
        data.map do |line|
          line
        end
      end.flatten
    end

    def output_heading
      display_line(data_heading)
    end

    def output_body
      display_table(table_body, table_headers)
    end

    private

    def error_key
      [response.code]
    end

    def error_message
      [{response.code => ERRORS[response.code]}]
    end

    def display_line(line)
      Formatador.display_line(line)
    end

    def display_table(table_data, headers)
      Formatador.display_table(table_data, headers)
    end
  end
end
