require "yaml"
require "pathname"

module Mythal
  class Config
    def initialize(default_data: {})
      @default_data = default_data
    end

    def defaults_file
      Pathname.new(File.expand_path("../../../default_data.yml", __FILE__))
    end

    def defaults
      return default_data unless default_data.empty?
      YAML.load(File.read(defaults_file))
    end

    private

    attr_reader :default_data
  end
end
