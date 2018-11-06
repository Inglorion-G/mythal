require "test_helper"

class Mythal::CLITest < Minitest::Test
  extend Minitest::Spec::DSL

  subject do
    Mythal::CLI.new
  end

  describe "#roll" do
    it "prints out a roll for a single die" do
      assert_output(/rolling d20... \d+\n\d+/) { subject.roll("1d20") }
    end

    it "prints out a roll and total for multiple dice" do
      assert_output(/rolling d8... \d+\nrolling d8... \d+/) { subject.roll("2d8") }
    end

    it "prints out a roll with a modifier" do
      assert_output(/rolling d20... \d+\n\d+ \+ 5\n\d+/) { subject.roll("1d20 + 5") }
    end

    it "prints out a roll with a negative modifier" do
      assert_output(/rolling d20... \d+\n\d+ \- 5\n\d+/) { subject.roll("1d20 - 5") }
    end
  end

  describe "#npc" do
    it "responds" do
      assert_respond_to subject, :npc
    end
  end
end
