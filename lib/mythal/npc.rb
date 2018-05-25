module Mythal
  class Npc
    include Procto.call

    def call
      character_description
    end

    private

    def character_description
      trait + " " + race + " " + dnd_class
    end

    def trait
      [
        "bombastic",
        "scrappy",
        "nimble",
        "argumentative",
        "grumpy",
        "drunk",
        "overly friendly",
        "touchy",
        "flirtatious",
        "ponderous",
        "inquisitive",
        "skeptical",
        "ruminating",
        "articulate",
        "ejaculatory (in terms of sound)",
        "timid",
        "bold",
        "dubious",
        "overly sympathetic",
        "boorish",
        "feckless",
        "nefarious",
        "honorable",
        "spasmodic",
      ].sample
    end

    def race
      [
        "orc",
        "half-orc",
        "human",
        "elf",
        "half-elf",
        "halfling",
        "dragonborn",
        "tiefling",
        "dwarf",
        "gnome",
      ].sample
    end

    def dnd_class
      [
        "fighter",
        "rogue",
        "wizard",
        "sorceror",
        "druid",
        "cleric",
        "bard",
        "monk",
        "warlock",
        "paladin",
      ].sample
    end
  end
end
