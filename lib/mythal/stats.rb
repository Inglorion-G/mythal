module Mythal
  class Stats
    VALID_ATTRS = %i[
      challenge_rating
      proficiency_bonus
      armor_class
      hit_points
      damage_per_round
      attack_bonus
      save_dc
      speed
      str
      dex
      con
      int
      wis
      cha
    ]

    VALID_CHALLENGE_RATINGS = %w[0 1/8 1/4 1/2 1 2]

    attr_reader :challenge_rating, :options

    def initialize(challenge_rating: "1/4", options: {})
      @challenge_rating = init_challenge_rating(challenge_rating)
      @options = options
      post_initialize
    end

    def attributes
      {
        challenge_rating: challenge_rating,
        proficiency_bonus: stats_by_cr["proficiency_bonus"],
        armor_class: stats_by_cr["armor_class"],
        hit_points: init_hit_points,
        damage_per_round: init_damage_per_round,
        attack_bonus: stats_by_cr["attack_bonus"],
        save_dc: stats_by_cr["save_dc"],
        speed: 30,
        str: 15,
        dex: 14,
        con: 13,
        int: 12,
        wis: 10,
        cha: 8,
      }.merge(user_overrides)
    end

    private

    def config
      Mythal::Config
    end

    def init_damage_per_round
      Range.new(*stats_by_cr["damage_per_round"].split("..").map(&:to_i)).to_a.sample
    end

    def stats_by_cr
      @stats_by_cr ||= begin
        raw_stats = config.npc_stats_by_challenge_rating
        raw_stats["Headers"].zip(raw_stats[challenge_rating]).to_h
      end
    end

    def init_challenge_rating(cr)
      default_cr = "1/4"
      return default_cr unless VALID_CHALLENGE_RATINGS.include?(cr)
      cr
    end

    def init_hit_points
      Range.new(*stats_by_cr["hit_points"].split("..").map(&:to_i)).to_a.sample
    end

    def user_overrides
      options.select do |k, _v|
        VALID_ATTRS.include?(k)
      end
    end

    def post_initialize
      attributes.each do |attr_name, attr_value|
        define_singleton_method(attr_name) { attr_value }
      end
    end
  end
end
