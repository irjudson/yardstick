require 'pathname'
require 'yard'

module Yardstick
  VERSION = '0.1.0'.freeze
  ROOT    = Pathname(__FILE__).dirname.parent.expand_path.freeze

  # Measure a list of files
  #
  # @example
  #   Yardstick.measure('article.rb')  # => [ Measurement ]
  #
  # @param [Array<#to_s>, #to_s] path
  #   optional list of paths to measure
  # @param [Hash] options
  #   optional configuration
  #
  # @return [MeasurementSet]
  #   the measurements for each file
  #
  # @api public
  def self.measure(path = 'lib/**/*.rb', options = {})
    Yardstick::Processor.process_path(path)
  end

  # Measure a string of code and YARD documentation
  #
  # @example
  #   string = "def my_method; end"
  #
  #   Yardstick.measure_string(string)  # => [ Measurement ]
  #
  # @param [#to_str] string
  #   the string to measure
  # @param [Hash] options
  #   optional configuration
  #
  # @return [MeasurementSet]
  #   the measurements for the string
  #
  # @api public
  def self.measure_string(string, options = {})
    Yardstick::Processor.process_string(string)
  end

end # module Yardstick

$LOAD_PATH.unshift(Yardstick::ROOT + 'lib')

require 'yardstick/core_ext/object'
require 'yardstick/yard_ext'
require 'yardstick/autoload'
