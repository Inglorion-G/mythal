# require "mythal"
require "thor"
require "procto"
require "mythal/version"
require "mythal/config"
require "mythal/roll"
require "mythal/npc"

module Mythal
  class CLI < Thor

    desc "roll", "roll some number of dice, plus modifiers e.g. 1d20, or 3d8 + 4"

    def roll(*args)
      puts Mythal::Roll.call(*args).message
    end

    desc "npc", "generate a random npc, e.g. 'a half-orc barbarian'"

    def npc
      puts Mythal::Npc.call(config: config)
    end

    private

    def config
      @config ||= Mythal::Config.new
    end
  end
end
