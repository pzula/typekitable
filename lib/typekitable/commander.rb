module Typekitable
  class Commander < Thor
    include Thor::Actions

    desc "re-authenticate", "Reset your Typekit API token"
    def re_authenticate
      Authenticator.new.get_authentication
      invoke :help
    end

    desc "kit_list", "Get a list of all of your kits"
    def kit_list
      result = formatted_response(response_for_command(:kit_list))
      result.output_heading
      result.output_body
    end

    desc "kit_add NAME DOMAINS", "Adds a new kit"
    def kit_add(name, domains)
      response = response_for_command(:kit_add,  { :name => name, :domains => [domains] })
      result = formatted_response(response)
      result.output_heading
      result.output_body
    end

    desc "kit_info KIT_ID", "Get information on a specific kit"
    def kit_info(kit_id)
      result = formatted_response(response_for_command(:kit_info, {}, kit_id))
      result.output_heading
      result.output_body
    end

    no_commands do
      def response_for_command(command_type, options = {}, resource_id = nil)
        RequestFetcher.new(command_type, options, resource_id).response
      end

      def formatted_response(response)
        ResponseFormatter.new(response)
      end
    end

  end
end
