# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'redis-renew/version'

Gem::Specification.new do |gem|
  gem.name          = "redis-renew"
  gem.version       = Redis::Renew::VERSION
  gem.authors       = ["Brandon Dewitt"]
  gem.email         = ["brandonsdewitt@gmail.com"]
  gem.description   = %q{ Simple gem that extends redis expiry of keys when accessed }
  gem.summary       = %q{ Simple gem that extends redis expiry of keys when accessed }
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency 'redis-store'
  gem.add_dependency 'redis-activesupport'

  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'bundler'
  gem.add_development_dependency 'mocha'
  gem.add_development_dependency 'minitest'
end
