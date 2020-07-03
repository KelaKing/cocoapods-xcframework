# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cocoapods-xcframework/gem_version.rb'

Gem::Specification.new do |spec|
  spec.name          = 'cocoapods-xcframework'
  spec.version       = CocoapodsXcframework::VERSION
  spec.authors       = ['KelaKing']
  spec.email         = ['jxwywxy@icloud.com']
  spec.description   = %q{A short description of cocoapods-xcframework.}
  spec.summary       = %q{A longer description of cocoapods-xcframework.}
  spec.homepage      = 'https://github.com/EXAMPLE/cocoapods-xcframework'
  spec.license       = 'MIT'

  spec.files         = Dir["lib/**/*.rb"]
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
end
