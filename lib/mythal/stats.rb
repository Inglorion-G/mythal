module Mythal
  class Stats
    VALID_ATTRS = %i[
      challenge_rating
      proficiency_bonus
      armor_class
      hit_points
      attack_bonus
      damage_per_round
      save_dc
      speed
      str
      dex
      con
      int
      wis
      cha
    ]

    attr_reader :challenge_rating, :options

    def initialize(challenge_rating: "1/4", options: {})
      @challenge_rating = challenge_rating
      @options = options
      post_initialize
    end

    def attributes
      {
        challenge_rating: challenge_rating,
        proficiency_bonus: 2,
        armor_class: 13,
        hit_points: init_hit_points,
        damage_per_round: 5,
        attack_bonus: 2,
        save_dc: 13,
        speed: 30,
        str: 15,
        dex: 14,
        con: 13,
        int: 12,
        wis: 10,
        cha: 8,
      }.merge(user_overrides)
    end

    def init_hit_points
      default_hit_points[challenge_rating].to_a.sample
    end

    def user_overrides
      options.select do |k, _v|
        VALID_ATTRS.include?(k)
      end
    end

    def default_hit_points
      {
        "0" => 1..6,
        "1/8" => 7..35,
        "1/4" => 36..49,
        "1/2" => 50..70,
        "1" => 71..85,
      }
    end

    def post_initialize
      attributes.each do |attr_name, attr_value|
        define_singleton_method(attr_name) { attr_value }
      end
    end
  end
end
