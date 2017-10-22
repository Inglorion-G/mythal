require "mythal"
require "thor"
require "procto"
require "mythal/roll"

module Mythal
  class CLI < Thor
    desc "roll", "roll some number of dice, plus modifiers e.g. 1d20, or 3d8 + 4"
    def roll(*args)
      puts Mythal::Roll.call(*args)
    end
  end
end
