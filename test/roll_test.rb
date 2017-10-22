require "test_helper"

class Mythal::RollTest < Minitest::Test
  extend Minitest::Spec::DSL

  subject do
    Mythal::Roll
  end

  describe "::call" do
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

      it "won't roll a d5" do
        assert_equal(
          "can't roll 1d5",
          subject.call("1d5"),
        )
      end

      it "won't roll 0 dice" do
        assert_equal(
          "can only roll 1 - 100 dice",
          subject.call("0d10"),
        )
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

      it "won't roll over 100 dice" do
        assert_equal(
          "can only roll 1 - 100 dice",
          subject.call("101d6"),
        )
      end
    end
  end
end
