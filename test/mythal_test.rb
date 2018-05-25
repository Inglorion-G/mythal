require "test_helper"

class MythalTest < Minitest::Test
  extend Minitest::Spec::DSL

  subject do
    Mythal
  end

  describe "version" do
    it "has a version number" do
      refute_nil ::Mythal::VERSION
    end
  end
end
