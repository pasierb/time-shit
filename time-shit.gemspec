# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "time_shit/version"

Gem::Specification.new do |s|
  s.name        = "time-shit"
  s.version     = TimeShit::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Michal Pasierbski"]
  s.email       = ["michal.pasierbski@sooftly.com"]
  s.homepage    = ""
  s.summary     = %q{}
  s.description = %q{}

  s.add_development_dependency('mocha')

  s.rubyforge_project = "time-shit"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
