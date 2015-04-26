module Typekitable
  class RequestFetcher
    attr_reader :type, :options


    VALID_TYPES = [:kit_list, :kit_add]
    VALID_OPTIONS = {
      :kit_add => [:name, :domains]
    }

    REQUEST_CONFIG = {
      :kit_list => {
        :request_path => "kits",
        :verb => "GET"
      },
      :kit_add => {
        :request_path => "kits",
        :verb => "POST"
      }
    }

    def initialize(type, options = {})
      @type = validate_type(type)
      @options = validate_options(options)
    end

    def request_path
      REQUEST_CONFIG[type][:request_path]
    end

    def verb
      REQUEST_CONFIG[type][:verb]
    end

    def parameters
      options
    end

    def response
      Request.new(request_path, verb, parameters).response
    end

    private

    def validate_type(type)
      raise InvalidTypeError unless VALID_TYPES.include?(type)

      return type
    end

    def validate_options(options_list)
      if options_list.empty? || VALID_OPTIONS[:kit_add].all? {|element| options_list.keys.include?(element) }
        return options_list
      else
        raise InvalidOptionsError
      end
    end
  end

  class InvalidTypeError < StandardError; end
  class InvalidOptionsError < StandardError; end
end
