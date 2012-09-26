require 'net/http'
require 'json'
require 'cgi'

module Gista
  # Base class for JSON requests to the Github API. ApiRequest knows how to send
  # a request with a JSON body and parse the results. Use `fetch` to read values
  # from the JSON response.
  #
  # Raises an exception when not authorized or when the API request responds
  # with something other than an OK.
  class ApiRequest
    URL          = 'api.github.com'
    PORT         = 443
    OPEN_TIMEOUT = 10
    READ_TIMEOUT = 10
    CONTENT_TYPE = 'application/json'

    # Read a key from the response.
    def fetch(key)
      result.fetch(key)
    end

    private

    def make_post(options = {})
      Net::HTTP::Post.new(path).tap do |request|
        request.content_type = CONTENT_TYPE
        request.body = JSON.dump(options)
        yield request if block_given?
        request
      end
    end

    def connection
      @connection ||= Net::HTTP.new(URL, PORT).tap do |connection|
        connection.use_ssl      = true
        connection.verify_mode  = OpenSSL::SSL::VERIFY_NONE
        connection.open_timeout = OPEN_TIMEOUT
        connection.read_timeout = READ_TIMEOUT
      end
    end

    def result
      @result ||= JSON.parse(response.body)
    end

    def response
      @response ||= begin
        connection.start { |http| http.request(request) }.tap do |r|
          if Net::HTTPUnauthorized === r
            raise Unauthorized
          elsif not Net::HTTPCreated === r
            raise RequestError, r.class
          end
        end
      rescue Timeout::Error
        raise 'Could not connect to Github API'
      end
    end
  end
end
