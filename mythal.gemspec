# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "mythal/version"

Gem::Specification.new do |spec|
  spec.name          = "mythal"
  spec.version       = Mythal::VERSION
  spec.authors       = ["George Groh"]
  spec.email         = ["george.groh@gmail.com"]

  spec.summary       = %q{Roll D&D dice from the command line.}
  spec.description   = %q{Mythal is a command-line dice roller. Supports d4-d20. e.g. mythal roll 1d20 | mythal roll 3d6}
  spec.homepage      = "https://github.com/Inglorion-G/mythal"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "pry", "~> 0.11.2"
  spec.add_dependency "thor", "~> 0.20"
  spec.add_dependency "procto"
end
