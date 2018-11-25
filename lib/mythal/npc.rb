module Mythal
  class Npc
    include Procto.call

    def initialize(config:)
      @config = config
    end

    def call
      self
    end

    def stats
      @stats ||= Mythal::Stats.new
    end

    def message
      <<~OUTPUT
        ---
        #{character_description}
        ---
        Armor Class: #{stats.armor_class}
        Hit Points: #{stats.hit_points}
        Speed: #{stats.speed}ft
        Attack: +#{stats.attack_bonus}
        Damage: #{stats.damage_per_round} slashing
        ---
      OUTPUT
    end

    private

    attr_reader :config

    def character_description
      trait + " " + race + " " + dnd_class
    end

    def dnd_class
      config.dnd_classes.sample
    end

    def race
      config.races.sample
    end

    def trait
      config.traits.sample
    end
  end
end
