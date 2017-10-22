require "test_helper"

class Mythal::RollTest < Minitest::Test
  extend Minitest::Spec::DSL

  subject do
    Mythal::Roll
  end

  describe "::call" do
    it "won't roll 0 dice" do
      assert_equal(
        "can only roll 1 - 100 dice",
        subject.call("0d10"),
      )
    end

    it "won't roll negative dice" do
      assert_equal(
        "can only roll 1 - 100 dice",
        subject.call("-8d10"),
      )
    end

    it "won't roll over 100 dice" do
      assert_equal(
        "can only roll 1 - 100 dice",
        subject.call("101d6"),
      )
    end

    describe "when rolling one die" do
      it "can roll a d4" do
        roll = subject.call("1d4")
        assert roll.between?(1, 4)
      end

      it "can roll a d6" do
        roll = subject.call("1d4")
        assert roll.between?(1, 4)
      end

      it "can roll a d8" do
        roll = subject.call("1d4")
        assert roll.between?(1, 4)
      end

      it "can roll a d10" do
        roll = subject.call("1d4")
        assert roll.between?(1, 4)
      end

      it "can roll a d12" do
        roll = subject.call("1d4")
        assert roll.between?(1, 4)
      end

      it "can roll a d20" do
        roll = subject.call("1d20")
        assert roll.between?(1, 20)
      end

      it "won't roll non-whitelisted dice variants" do
        dice_variants = %w(2 3 5 7 9 11 13 14 15 17 18 19 67 1001 9746)
        dice_variants.each do |variant|
          assert_equal "can't roll 1d#{variant}", subject.call("1d#{variant}")
        end
      end
    end

    describe "when rolling multiple dice" do
      it "can roll 2d8" do
        roll = subject.call("2d8")
        assert roll.between?(2, 16)
      end

      it "can roll 4d10" do
        roll = subject.call("4d10")
        assert roll.between?(4, 40)
      end

      it "can roll 5d12" do
        roll = subject.call("5d12")
        assert roll.between?(5, 60)
      end
    end
  end
end
