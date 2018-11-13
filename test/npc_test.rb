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

  describe "::call" do
    it "returns a string describing an NPC" do
      assert_equal "funky gnome druid", subject
    end
  end
end
