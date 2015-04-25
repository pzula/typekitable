module Typekitable
  module Tokenizer
    TOKEN_STORE = File.absolute_path('.typekitable', Dir.home)

    def self.store(token)
      File.open(TOKEN_STORE, 'w') do |file|
        file.write(token)
      end
    end

    def self.has_token?
      File.exist?(TOKEN_STORE)
    end

    def self.get_token
      return unless has_token?

      File.open(TOKEN_STORE, 'r') do |file|
        file.gets
      end
    end
  end
end
