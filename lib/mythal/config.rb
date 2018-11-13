require "yaml"
require "pathname"

module Mythal
  class Config
    def initialize(user_overrides: {})
      @user_overrides = user_overrides
    end

    def traits
      config["traits"]
    end

    def races
      config["races"]
    end

    def dnd_classes
      config["dnd_classes"]
    end

    def config
      if user_overrides.empty?
        @config ||= YAML.load(File.read(config_file))
      else
        user_overrides
      end
    end

    private

    attr_reader :user_overrides

    def config_file
      Pathname.new(File.expand_path("../../../config.yml", __FILE__))
    end
  end
end
