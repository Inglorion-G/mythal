module Mythal
  class Npc
    include Procto.call

    def initialize(config:, challenge_rating: "1/4", user_overrides: {})
      @config = config
      @challenge_rating = challenge_rating
      @user_overrides = user_overrides
    end

    def call
      self
    end

    def stats
      @stats ||= Mythal::Stats.new(
        challenge_rating: challenge_rating,
        options: (user_overrides || {}),
      )
    end

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

    attr_reader :config, :user_overrides, :challenge_rating
  end
end
