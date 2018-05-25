# require "mythal"
require "thor"
require "procto"
require "mythal/version"
require "mythal/roll"
require "mythal/npc"

module Mythal
  class CLI < Thor

    desc "roll", "roll some number of dice, plus modifiers e.g. 1d20, or 3d8 + 4"

    def roll(*args)
      puts Mythal::Roll.call(*args)
    end

    desc "npc", "generate a random npc, e.g. 'a half-orc barbarian'"

    def npc
      puts Mythal::Npc.call
    end
  end
end
