module Mythal
  class CLI < Thor

    desc "roll", "roll some number of dice, plus modifiers e.g. 1d20, or 3d8 + 4"

    def roll(*args)
      puts Mythal::Roll.call(*args).message
    end

    desc "npc", "generate a random npc, e.g. 'a half-orc barbarian'"
    method_option :challenge_rating, type: :string, aliases: "--cr"
    method_option :options, type: :hash, aliases: "-o"

    def npc
      puts Mythal::Npc.call(
        challenge_rating: options[:challenge_rating],
        user_overrides: options[:options]&.transform_keys(&:to_sym),
      ).message
    end
  end
end
