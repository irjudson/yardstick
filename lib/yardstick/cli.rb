require 'optparse'

module Yardstick
  class CLI

    # Parse the command line options, and run the command
    #
    # @example
    #   Yardstick::CLI.run(%w[ article.rb ])  # => [ Measurement ]
    #
    # @param [Array] *args
    #   arguments passed in from the command line
    #
    # @return [MeasurementSet]
    #   the measurement for each file
    #
    # @api public
    def self.run(*args)
      measurements = Yardstick.measure(*parse_options(args))
      measurements.puts
      measurements
    end

    # Parse the options provided from the command-line
    #
    # @param [Array<String>] args
    #   the command-line options
    #
    # @return [Array(Array<String>, Hash)]
    #   the list of files, and options parsed from the command-line
    #
    # @api private
    def self.parse_options(args)
      args << '--help' if args.empty?
      options = {}
      option_parser(options).parse!(args)
      [ args, options ]
    rescue OptionParser::InvalidOption => error
      display_exit(error.message)
    end

    # Return an OptionParser instance for the command-line app
    #
    # @param [Hash] options
    #   the options to set when parsing the command-line arguments
    #
    # @return [OptionParser]
    #   the option parser instance
    #
    # @api private
    def self.option_parser(options)
      opts = OptionParser.new
      opts.on_tail('-v', '--version', 'print version information and exit') { display_exit("#{opts.program_name} #{Yardstick::VERSION}") }
      opts.on_tail('-h', '--help',    'display this help and exit')         { display_exit(opts.to_s) }
      opts
    end

    # Display a message and exit
    #
    # @param [#to_str] message
    #   the message to display
    #
    # @return [undefined]
    #
    # @api private
    def self.display_exit(message)
      puts message.to_str
      exit
    end

    class << self
      private :option_parser, :parse_options, :display_exit
    end

  end # module CLI
end # module Yardstick
