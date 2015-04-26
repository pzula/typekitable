module Typekitable
  class Request
    attr_reader :path, :verb, :parameters

    BASE_URL = "https://typekit.com/api/v1/json/"

    def initialize(path, verb, parameters)
      @path = path
      @verb = verb
      @parameters = parameters
    end

    def token
      Tokenizer.get_token
    end

    def response
      case verb
        when "GET" then get_request_response
        when "POST" then post_request_response
      end
    end

    def uri
      URI.parse(BASE_URL + path)
    end

    def headers
      { "X-Typekit-Token" => token }
    end

    private

    def http_request
      Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |https|
        yield(https, uri)
      end
    end

    def get_request_response
      http_request do |https, uri|
        response = https.get(uri.path, headers)
        build_response(response.code, response.message, response.body)
      end
    end

    def post_request_response
      req = Net::HTTP::Post.new(uri.path, headers)
      req.set_form_data(parameters)
      http_request do |https, uri|
        response = https.request(req)
        build_response(response.code, response.message, response.body)
      end
    end

    def build_response(code, message, body)
      Response.new(:code => code, :message => message, :body => body)
    end
  end

  class Response < Struct.new(:code, :message, :body)
    def initialize(from_hash)
      super(*from_hash.values_at(*members))
    end
  end
end
