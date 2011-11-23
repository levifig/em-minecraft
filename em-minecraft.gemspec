# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "em-minecraft/version"

Gem::Specification.new do |s|
  s.name        = "em-minecraft"
  s.version     = EventMachine::Minecraft::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Dave Newman"]
  s.email       = ["dave@minefold.com"]
  s.homepage    = "http://github.com/minefold/em-minecraft"
  s.summary     = %q{Minecraft protocol for eventmachine}
  s.description = %q{Minecraft protocol for eventmachine}

  s.rubyforge_project = "em-minecraft"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency("eventmachine", "~> 1.0.0.beta.3")
  s.add_development_dependency("eventmachine", "~> 1.0.0.beta.3")
  s.add_development_dependency('rake')
end