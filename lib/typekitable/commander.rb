module Typekitable
  class Commander < Thor
    include Thor::Actions

    desc "re-authenticate", "Reset your Typekit API token"
    def re_authenticate
      Authenticator.new.get_authentication
      invoke :help
    end
  end
end
