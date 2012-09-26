module Gista
  # Create an object that responds to `username` and `password` messages by
  # prompting the user on the command line. Helpful when creating a
  # command-line client. When using as a library, simply substitute with a
  # `Struct` or something similar.
  #
  # @example Asking the user for username and password
  #   lp = LoginPrompt.new
  #   lp.username
  #   # ... prompt for username and password...
  #   # => "username"
  #   lp.password
  #   # => "password"
  #
  class LoginPrompt
    def initialize
      @username = nil
      @password = nil
    end

    # Return the username if set, or prompt the user to enter both his username
    # and password.
    #
    # @return [String]
    def username
      prompt unless @username
      @username
    end

    # Return the password if set, or prompt the user to enter both his username
    # and password.
    #
    # @return [String]
    def password
      prompt unless @password
      @password
    end

    private

    def prompt
      $stdout.puts 'Please authenticate with your Github credentials:'
      $stdout.print 'Username: '
      @username = $stdin.gets.strip
      $stdout.print 'Password: '
      @password = begin
        `stty -echo` rescue nil
        $stdin.gets.strip
      ensure
        `stty echo` rescue nil
      end
      $stdout.puts ''
    end
  end
end
