require 'optparse'

module Gista
  # Parse options given on the command line into an options hash suitable for a
  # `GistRequest` object.
  #
  # This provides the default options:
  #
  # * Gists are private by default
  # * When reading from `STDIN`, the file is titled 'untitled'
  #
  # When any options are left after parsing all the flags, they are treated as
  # filenames. They will be added to the options as files in the Gist. When no
  # arguments are left, input is read from `STDIN` and its contents will be
  # added to the options hash as a single file.
  #
  # This also provides the `--help` and `--version` options for the
  # command-line client.
  class Options
    # Command line options, flags and filenames
    #
    # @return [Array]
    attr_reader :args

    def initialize(args)
      @args = args
      @options = { public: false }
      @stdin_filename = 'untitled'
    end

    # @return [Hash]
    def options
      parse_options
      parse_files
      @options
    end

    private

    def parse_files
      if args.any?
        @options[:files] = args.inject({}) do |acc, filename|
          acc.merge File.basename(filename) => { content: File.read(filename) }
        end
      else
        @options[:files] = {
          @stdin_filename => { content: $stdin.read }
        }
      end
    end

    def parse_options
      OptionParser.new do |opts|
        opts.banner = 'Usage: gista [options] [file..]'
        opts.separator ''
        opts.separator 'Gist options:'
        opts.on('-p', '--[no-]public', 'Create a public gist') do |v|
          @options[:public] = v
        end
        opts.on('-f', '--filename [FILENAME]', 'Specify filename to use when reading from STDIN') do |f|
          @stdin_filename = f
        end
        opts.separator ''
        opts.separator 'Generic options:'
        opts.on_tail('-h', '--help', 'Show brief usage information') do
          puts opts
          exit
        end
        opts.on_tail('-v', '--version', 'Show version information') do
          puts VERSION
          exit
        end
      end.parse!(args)
    end
  end
end
