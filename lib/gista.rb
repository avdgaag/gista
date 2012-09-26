require 'gista/version'
require 'gista/api_request'
require 'gista/token_request'
require 'gista/gist_request'
require 'gista/login_prompt'
require 'gista/user_token'
require 'gista/options'

# Gista allows for easily creating Gists from the command line or a Ruby
# program. For full instructions on how to use it from the command line, run
# `gista --help`.
#
# @example From the command line, listing filenames
#   $ gista my_file.rb another_file.rb
#   https://gist.github.com/...
#
# @example From the command line, reading STDIN
#   $ rspec | gista
#   https://gist.github.com/...
#   $ gista < my_file.rb
#   https://gist.github.com/...
#
# @example From a Ruby program
#   require 'gista'
#   Gista.post_and_get_url(oauth_token, options)
#
module Gista
  # Exception raised when trying to do stuff on Github that you are not
  # authorized for.
  class Unauthorized < StandardError
    def initialize(*args)
      super "Authorization with Github failed. Please remove your token file and try again to re-authenticate.", *args
    end
  end

  # Exception raised when the request does not respond as we expected.
  class RequestError < StandardError
    def initialize(*args)
      super *args.unshift("Github responded with #{args.shift}")
    end
  end

  module_function

  # Make a request to the Github API using the given authorization token
  # and options. Returns the URL to the Gist if it was successful.
  #
  # @param token <String>
  # @param options <Hash>
  def post_and_get_url(token, options)
    GistRequest.new(token, options).fetch('html_url')
  end
end
