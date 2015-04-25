module Typekitable
  class Authenticator < Thor
    include Thor::Actions

    no_commands do
      def get_authentication
        if no?("Do you have a Typekit API token? [y/N]", :yellow)
          say("Generate an API token at https://typekit.com/account/tokens and come back once you have it, we will only ask for it once", :red)
          exit
        else
          request_token
        end
      end

      def request_token
        token = ask("What is your Typekit API token?:", :red)
        Tokenizer.store(token)
        say("Thank you, your Typekit API token has been stored.", :green)
      end
    end
  end
end
