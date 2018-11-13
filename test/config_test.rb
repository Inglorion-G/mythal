require "test_helper"

class Mythal::ConfigTest < Minitest::Test
  extend Minitest::Spec::DSL

  subject do
    Mythal::Config.new
  end

  describe "#config" do
    it "returns a parsed defaults object" do
      assert_kind_of Hash, subject.config
    end

    it "returns arrays for each key" do
      subject.config.each do |_k, v|
        assert_kind_of Array, v
      end
    end
  end
end
