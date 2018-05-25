require "test_helper"

class Mythal::NpcTest < Minitest::Test
  extend Minitest::Spec::DSL

  subject do
    Mythal::Npc
  end

  describe "::call" do
    it "responds" do
      assert_respond_to subject, :call
    end

    it "returns a string" do
      assert subject.call.is_a?(String)
    end
  end
end
