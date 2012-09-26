module Gista
  # Acquire and store an OAuth authorization token in the user's home directory.
  #
  # @see TokenRequest
  class UserToken

    # Default path to file to store the token in
    #
    # @return [String]
    DEFAULT_CONFIG_FILE = File.expand_path('~/.gista')

    # @return [#fetch] any object that returns the token to use
    # when calling `fetch('token')`.
    attr_reader :authoriser

    def initialize(authoriser, token_file = nil)
      @authoriser, @token_file = authoriser, token_file
    end

    # Return the user token. Either read it from disk, or request a new token
    # with the Github API using the credentials from `creds`.
    #
    # @return [String]
    def token
      return read_from_config_file if has_config_file?
      request_token.tap do |token|
        write_to_config_file(token)
      end
    end

    # @return [String] path to file containing a re-usable token
    def token_file
      @token_file || DEFAULT_CONFIG_FILE
    end

    private

    def request_token
      authoriser.fetch('token')
    end

    def write_to_config_file(content)
      File.open(token_file, 'w') do |f|
        f.write content
      end
    end

    def read_from_config_file
      File.read(token_file).chomp
    end

    def has_config_file?
      File.exist?(token_file)
    end
  end
end
