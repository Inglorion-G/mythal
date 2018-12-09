require "yaml"
require "pathname"

module Mythal
  class Config
    class << self
      attr_reader :settings

      def config
        @config ||= YAML.load(File.read(config_file))
      end

      def dnd_classes
        config["dnd_classes"]
      end

      def npc_stats_by_challenge_rating
        config["npc_stats_by_challenge_rating"]
      end

      def races
        config["races"]
      end

      def traits
        config["traits"]
      end

      private

      attr_reader :user_overrides

      def config_file
        Pathname.new(File.expand_path("../../../config.yml", __FILE__))
      end
    end
  end
end
