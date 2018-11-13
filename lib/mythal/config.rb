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
      @config ||= user_overrides.empty? ? YAML.load(File.read(config_file)) : user_overrides
    end

    private

    attr_reader :user_overrides

    def config_file
      Pathname.new(File.expand_path("../../../config.yml", __FILE__))
    end
  end
end
