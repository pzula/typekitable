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

    def http_request
      Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |https|
        yield(https, uri)
      end
    end

    def get_request_response
      http_request do |https, uri|
        https.get(uri.path, headers).body
      end
    end

    def post_request_reponse
      http_request do |http, uri|
        https.post(uri.path, headers).body
      end
    end

    def uri
      URI.parse(BASE_URL + path)
    end

    def headers
      { "X-Typekit-Token" => token }
    end

  end
end
