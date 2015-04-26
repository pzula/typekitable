module Typekitable
  class RequestFetcher
    attr_reader :type

    VALID_TYPES = [:kit_list]
    REQUEST_OPTIONS = {
      :kit_list => {
        :request_path => "kits",
        :verb => "GET"
      }
    }

    def initialize(type)
      @type = validate_type(type)
    end

    def request_path
      REQUEST_OPTIONS[type][:request_path]
    end

    def verb
      REQUEST_OPTIONS[type][:verb]
    end

    def response
      Request.new(request_path, verb).response
    end

    private

    def validate_type(type)
      raise InvalidTypeError unless VALID_TYPES.include?(type)

      return type
    end
  end

  class InvalidTypeError < StandardError; end
end
