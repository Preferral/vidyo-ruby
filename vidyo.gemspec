# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'vidyo/version'

Gem::Specification.new do |spec|
  spec.name          = "vidyo"
  spec.version       = Vidyo::VERSION
  spec.authors       = ["Jon Gautsch"]
  spec.email         = ["jon@preferral.com"]
  spec.summary       = %q{Ruby gem for interacting with Vidyo instance}
  spec.description   = %q{Ruby gem for interacting with a Vidyo instance}
  spec.homepage      = "https://preferral.com"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rspec-nc"
  spec.add_development_dependency "guard"
  spec.add_development_dependency "guard-rspec"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "pry-remote"
  spec.add_development_dependency "pry-nav"

  spec.add_runtime_dependency 'savon', '~> 2.9.0'
end
