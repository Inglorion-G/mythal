require "test_helper"

class Mythal::StatsTest < Minitest::Test
  extend Minitest::Spec::DSL

  describe "#challenge_rating" do
    subject do
      Mythal::Stats
    end

    let(:valid_challenge_ratings) do
      %w[
        0
        1/8
        1/4
        1/2
        1
      ]
    end

    it "defaults to a challenge rating of 1/4 if none is specified" do
      assert_equal "1/4", subject.new.challenge_rating
    end

    it "returns the specified challenge rating if it exists" do
      assert_equal "1", subject.new(challenge_rating: "1").challenge_rating
    end

    it "accepts challenge ratings as string fractions `1/8`, `1/4` and `1/2`" do
      valid_challenge_ratings.each do |cr|
        assert_equal cr, subject.new(challenge_rating: cr).challenge_rating
      end
    end

    it "falls back to the default if a passed-in challenge rating is invalid" do
      stat_block = subject.new(challenge_rating: 9_999)
      assert_equal "1/4", stat_block.challenge_rating
    end
  end

  describe "#hit_points" do
    subject do
      Mythal::Stats
    end

    let(:cr_half_hp) { (50..70) }
    let(:cr_quarter_hp) { (36..49) }

    describe "when hit_points are directly specified" do
      it "returns the passed-in hit points when they are specified" do
        stats = subject.new(options: { hit_points: 27 })
        assert_equal 27, stats.hit_points
      end

      it "generates a hit point value based on CR when not specified" do
        stats = subject.new(challenge_rating: "1/2")
        assert stats.hit_points.between?(cr_half_hp.min, cr_half_hp.max)
      end
    end

    describe "when hit_points are not specified" do
      it "generates a hit point value based on a default CR of 1/4" do
        stats = subject.new(challenge_rating: nil)
        assert stats.hit_points.between?(cr_quarter_hp.min, cr_quarter_hp.max)
      end
    end
  end

  describe "#attributes" do
    subject do
      Mythal::Stats.new(options: options)
    end

    describe "when no options are passed" do
      let(:options) { {} }

      it "returns a hash of attributes" do
        expected_keys = %i[
          challenge_rating
          proficiency_bonus
          armor_class
          damage_per_round
          attack_bonus
          hit_points
          save_dc
          speed
          str
          dex
          con
          int
          wis
          cha
        ]

        assert_equal expected_keys.sort, subject.attributes.keys.sort
      end
    end

    describe "when options are passed" do
      let(:options) do
        {
          challenge_rating: 1,
          proficiency_bonus: 2,
          armor_class: 13,
          hit_points: 40,
          damage_per_round: 5,
          attack_bonus: 3,
          save_dc: 12,
          speed: 30,
          str: 15,
          dex: 14,
          con: 13,
          int: 12,
          wis: 10,
          cha: 8,
        }
      end

      it "returns a hash of attributes with user overrides" do
        assert_equal options, subject.attributes
      end
    end
  end
end
