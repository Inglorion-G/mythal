module Mythal
  class Npc
    include Procto.call

    def initialize(config:)
      @config = config
    end

    def call
      character_description
    end

    private

    attr_reader :config

    def character_description
      trait + " " + race + " " + dnd_class
    end

    def trait
      config.defaults["traits"].sample
    end

    def race
      config.defaults["races"].sample
    end

    def dnd_class
      config.defaults["dnd_classes"].sample
    end
  end
end
