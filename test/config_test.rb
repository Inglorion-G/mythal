require "test_helper"

class Mythal::ConfigTest < Minitest::Test
  extend Minitest::Spec::DSL

  subject do
    Mythal::Config
  end

  describe "::config" do
    it "returns a parsed defaults object" do
      assert_kind_of Hash, subject.config
    end
  end

  describe "::races" do
    it "returns an array of races" do
      races = subject.races
      assert_kind_of Array, races
      assert_includes races, "orc"
    end
  end

  describe "::dnd_classes" do
    it "returns an array of dnd_classes" do
      dnd_classes = subject.dnd_classes
      assert_kind_of Array, dnd_classes
      assert_includes dnd_classes, "fighter"
    end
  end

  describe "::traits" do
    it "returns an array of traits" do
      traits = subject.traits
      assert_kind_of Array, traits
      assert_includes traits, "bombastic"
    end
  end

  describe "::npc_stats_by_challenge_rating" do
    it "returns a hash of stats" do
      assert_kind_of Hash, subject.npc_stats_by_challenge_rating
    end
  end
end
