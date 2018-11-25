require "test_helper"
require "mythal/stats"

class Mythal::StatsTest < Minitest::Test
  extend Minitest::Spec::DSL

  subject do
    Mythal::Stats.new(options: params)
  end

  describe "#attributes" do
    describe "when no options are passed" do
      let(:params) { {} }

      it "returns a hash of attributes" do
        expected = {
          challenge_rating: "1/4",
          proficiency_bonus: 2,
          armor_class: 13,
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
        }

        dynamic_keys = [:hit_points]
        actual = subject.attributes.reject { |k| dynamic_keys.include?(k) }

        assert_equal expected, actual
      end
    end

    describe "when options are passed" do
      let(:params) do
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
        assert_equal params, subject.attributes
      end
    end
  end
end
