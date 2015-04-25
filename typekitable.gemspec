# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'typekitable/version'

Gem::Specification.new do |spec|
  spec.name          = "typekitable"
  spec.version       = Typekitable::VERSION
  spec.authors       = ["Persa Zula"]
  spec.email         = ["persa@persazula.com"]
  spec.summary       = %q{A CLI for interacting with your Typekit kits. No need to form your own requests!}
  spec.homepage      = "http://github.com/pzula/typekitable"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "thor", "0.19.1"
  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
