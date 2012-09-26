module Gista
  # Special Github API request to create a new gist. It requires an OAuth token
  # for authorization, and options for what file to post.
  #
  # See the API docs for what options are expected to create a new Gist.
  #
  # @example Creating a Gist
  #   GistRequest.new('acc829df', {
  #     public: false,
  #     files: {
  #       file1: { content: 'my content' }
  #     }
  #   }).fetch('html_url')
  #   # => "http://gist.github.com/fbed697547047a733434"
  #
  # @see http://developer.github.com/v3/gists/#create-a-gist
  class GistRequest < ApiRequest
    # Authorization token to authorize with Github.
    #
    # @see http://developer.github.com/v3/oauth/#scopes
    # @see Gista::TokenRequest
    # @return [String]
    attr_reader :token

    # Options containing information about files, filenames and visibility
    # @return [Hash]
    attr_reader :options

    def initialize(token, options = {})
      @token, @options = token, options
    end

    private

    def request
      make_post(options)
    end

    def path
      "/gists?access_token=#{CGI.escape(token)}"
    end
  end
end
