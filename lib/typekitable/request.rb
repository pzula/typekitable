module Typekitable
  class Request
    attr_reader :path, :verb

    BASE_URL = "https://typekit.com/api/v1/json/"

    def initialize(path, verb)
      @path = path
      @verb = verb
    end

    def token
      Tokenizer.get_token
    end

    def response
      case verb
        when "GET" then get_request_response
        when "POST" then post_request_reponse
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

    def post_request_reponse
      http_request do |http, uri|
        response = https.post(uri.path, headers)
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
