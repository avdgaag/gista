module Gista
  # Request to the Github API to authorize with a username and password and
  # acquire an OAuth token, which can be stored and re-used for password-less
  # authorization.
  #
  # @example Request a token
  #   credentials = OpenStruct.new(username: 'foo', password: 'bar')
  #   TokenRequest.new(credentials).fetch('token')
  #
  # @see http://developer.github.com/v3/oauth/#scopes
  class TokenRequest < ApiRequest
    # An object that contains a username and password
    #
    # @see LoginPrompt
    # @return [#username, #password]
    attr_reader :credentials

    def initialize(credentials)
      @credentials = credentials
    end

    private

    def path
      '/authorizations'
    end

    def request
      options = {
        scopes:   [:gist],
        note:     'Gista gem',
        note_url: 'http://avdgaag.github.com'
      }
      make_post(options) do |request|
        request.basic_auth(credentials.username, credentials.password)
      end
    end
  end
end
