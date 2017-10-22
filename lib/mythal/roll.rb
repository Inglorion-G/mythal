module Mythal
  class Roll
    include Procto.call

    DICE_VARIANTS = [4, 6, 8, 10, 12, 20]
    NUMBER_OF_DICE = 1..100

    def initialize(*dice_string)
      @dice_string = dice_string.join
    end

    def call
      result
    end

    private

    attr_reader :dice_string, :number_of_dice, :denomination, :bonus

    def result
      @number_of_dice = match_data[1].to_i
      @denomination = match_data[2].to_i
      @bonus = match_data[3]&.to_i || 0

      return "can't roll #{dice_string}" unless valid_denomination?
      return "can only roll #{min_dice} - #{max_dice} dice" unless valid_number_of_dice?

      random_dice_roll + bonus
    end

    def random_dice_roll
      number_of_dice.times.inject(0) do |memo, _val|
        current_roll = rand(1..denomination)
        puts "rolling d#{denomination}... #{current_roll}"
        memo += current_roll
      end
    end

    def match_data
      @match_data ||= (pattern.match(dice_string))
    end

    def pattern
      @pattern ||= /^(-?\d+)d(\d+)\+?(\d+)?$/
    end

    def valid_denomination?
      DICE_VARIANTS.include?(denomination)
    end

    def valid_number_of_dice?
      NUMBER_OF_DICE.include?(number_of_dice)
    end

    def min_dice
      NUMBER_OF_DICE.min
    end

    def max_dice
      NUMBER_OF_DICE.max
    end
  end
end
