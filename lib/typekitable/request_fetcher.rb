module Typekitable
  class RequestFetcher
    attr_reader :type, :options, :resource_id


    VALID_TYPES = [:kit_list, :kit_add, :kit_info]
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
      },
      :kit_info => {
        :request_path => "kits",
        :verb => "GET"
      }
    }

    def initialize(type, options = {}, resource_id = nil)
      @type = validate_type(type)
      @options = validate_options(options)
      @resource_id = resource_id
    end

    def request_path
      REQUEST_CONFIG[type][:request_path].concat("/#{resource_id}").squeeze("/")
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
