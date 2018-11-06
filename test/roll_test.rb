require "test_helper"

class Mythal::RollTest < Minitest::Test
  extend Minitest::Spec::DSL

  subject do
    Mythal::Roll
  end

  describe "::call" do
    it "returns a dice result object" do
      result = subject.call("1d20")
      assert result.is_a?(Mythal::Roll::DiceRollResult), "result should be a DiceRollResult"
    end

    it "won't roll 0 dice" do
      result = subject.call("0d10")
      refute result.success?
      assert_equal "can only roll 1 - 100 dice", result.message
    end

    it "won't roll negative dice" do
      result = subject.call("-8d10")
      refute result.success?
      assert_equal "can only roll 1 - 100 dice", result.message
    end

    it "won't roll over 100 dice" do
      result = subject.call("101d6")
      refute result.success?
      assert_equal "can only roll 1 - 100 dice", result.message
    end

    it "won't roll non-whitelisted dice variants" do
      dice_variants = %w(2 3 5 7 9 11 13 14 15 17 18 19 67 1001 9746)
      dice_variants.each do |variant|
        result = subject.call("1d#{variant}")
        refute result.success?
        assert_equal "can't roll 1d#{variant}", result.message
      end
    end

    describe "DiceRollResult#rolls" do
    end

    describe "when rolling one die" do
      it "can roll a d4" do
        result = subject.call("1d4")
        assert result.total.between?(1, 4)
      end

      it "can roll a d6" do
        result = subject.call("1d4")
        assert result.total.between?(1, 4)
      end

      it "can roll a d8" do
        result = subject.call("1d4")
        assert result.total.between?(1, 4)
      end

      it "can roll a d10" do
        result = subject.call("1d4")
        assert result.total.between?(1, 4)
      end

      it "can roll a d12" do
        result = subject.call("1d4")
        assert result.total.between?(1, 4)
      end

      it "can roll a d20" do
        result = subject.call("1d20")
        assert result.total.between?(1, 20)
      end

      it "can add a positive modifier" do
        result = subject.call("1d20+20")
        assert result.total.between?(21, 40)
      end

      it "can add a negative modifier" do
        result = subject.call("1d20-20")
        assert result.total.between?(-19, 0), "result should be negative or zero"
      end
    end

    describe "when rolling multiple dice" do
      it "can roll 2d8" do
        result = subject.call("2d8")
        assert result.total.between?(2, 16)
      end

      it "can roll 4d10" do
        result = subject.call("4d10")
        assert result.total.between?(4, 40)
      end

      it "can roll 5d12" do
        result = subject.call("5d12")
        assert result.total.between?(5, 60)
      end
    end
  end
end
