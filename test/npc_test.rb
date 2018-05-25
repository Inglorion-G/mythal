require "test_helper"

class Mythal::NpcTest < Minitest::Test
  extend Minitest::Spec::DSL

  subject do
    ::Mythal::Npc

    describe "::call" do
      it "responds" do
        assert respond_to :call
      end
    end
  end
end
