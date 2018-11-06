module Mythal
  class Roll
    include Procto.call

    DICE_VARIANTS = [4, 6, 8, 10, 12, 20]
    NUMBER_OF_DICE = 1..100

    def initialize(*dice_string)
      @dice_string = dice_string.join.gsub(" ", '')
    end

    def call
      result
    end

    private

    attr_reader :dice_string, :number_of_dice, :denomination, :modifier

    class DiceRollResult
      attr_reader :rolls, :modifier, :message, :total, :success

      def initialize(rolls: [], modifier: 0, message: "", total: 0, success: false)
        @rolls = rolls
        @modifier = modifier
        @success = success
        @message = message
        @total = total
      end

      def success?
        success
      end
    end

    def result
      return DiceRollResult.new(message: "can't roll #{dice_string}") unless match_data

      parse_input_string

      return DiceRollResult.new(message: "can't roll #{dice_string}") unless valid_denomination?
      return DiceRollResult.new(message: "can only roll #{min_dice} - #{max_dice} dice") unless valid_number_of_dice?

      rolls = Array.new(number_of_dice) { random_dice_roll }
      total = rolls.inject(:+) + modifier
      message = format_output_message(rolls, total)

      DiceRollResult.new(
        rolls: rolls,
        total: total,
        message: message,
        success: true,
        modifier: modifier,
      )
    end

    def format_output_message(rolls, total)
      subtotal = rolls.inject(:+)
      sign = modifier > 0 ? "+" : "-"
      messages = rolls.map { |roll| "rolling d#{denomination}... #{roll}" }
      messages << "#{subtotal} #{sign} #{modifier.abs}" unless modifier.zero?
      messages << total
      messages.join("\n")
    end

    def match_data
      @match_data ||= pattern.match(dice_string)
    end

    def parse_input_string
      @number_of_dice = match_data[1].to_i
      @denomination = match_data[2].to_i
      @modifier = match_data[3] ? match_data[3].to_i : 0
    end

    def random_dice_roll
      rand(1..denomination)
    end

    def pattern
      @pattern ||= /^(-?\d+)d(\d+)?([+-]\d+)?$/
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
