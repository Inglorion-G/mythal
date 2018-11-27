require "test_helper"

class Mythal::NpcTest < Minitest::Test
  extend Minitest::Spec::DSL

  subject do
    Mythal::Npc.call(config: config)
  end

  let(:config) do
    Mythal::Config.new(user_overrides: {
      "traits" => ["funky"],
      "races" => ["gnome"],
      "dnd_classes" => ["druid"],
    })
  end

  describe "responds to cli interface" do
    it "responds to #message" do
      response_obj = subject
      assert_respond_to response_obj, :message
    end
  end

  describe "#message" do
    it "generates a string describing an NPC" do
      message = subject.message

      assert_match(/Armor Class/, message)
      assert_match(/Hit Points/, message)
      assert_match(/Speed/, message)
    end
  end

  describe "#stats" do
    it "generates a stat block for an NPC" do
      stats = subject.stats

      named_stats = %i[
        hit_points
        armor_class
        speed
        proficiency_bonus
        damage_per_round
      ]

      named_stats.each do |stat|
        assert_respond_to stats, stat
      end
    end

    describe "challenge_rating" do
      subject do
        Mythal::Npc
      end

      it "generates a 1/4 challenge rating NPC if no CR is specified" do
        npc = subject.call(config: config)
        assert_equal "1/4", npc.stats.challenge_rating
      end

      it "generates an appropriate challenge rating if CR is specified" do
        npc = subject.call(config: config, challenge_rating: "1/8")
        assert_equal "1/8", npc.stats.challenge_rating
      end
    end
  end
end
