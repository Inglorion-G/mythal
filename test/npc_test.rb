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
      assert_respond_to stats, :hit_points
      assert_respond_to stats, :armor_class
      assert_respond_to stats, :speed

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

    it "generates a value for hitpoints between 1 and 10" do
      assert subject.stats.hit_points.between?(36, 49)
    end
  end
end
