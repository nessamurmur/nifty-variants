# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'nifty/variants/version'

Gem::Specification.new do |spec|
  spec.name          = "nifty-variants"
  spec.version       = Nifty::Variants::VERSION
  spec.required_ruby_version = '~> 2.1.0'
  spec.authors       = ["Nate West"]
  spec.email         = ["natescott.west@gmail.com"]
  spec.summary       = %q{Variants in Ruby}
  spec.description   = %q{Variants in Ruby}
  spec.homepage      = "http://github.com/niftyn8/nifty-variants"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency 'rspec-core', '~> 3.1.3'
  spec.add_development_dependency 'rspec', '~> 3.1.0'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'degenerate'
end
