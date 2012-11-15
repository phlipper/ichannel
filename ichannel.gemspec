# -*- encoding: utf-8 -*-
require './lib/ichannel/version'
Gem::Specification.new do |gem|
  gem.name          = "ichannel"
  gem.version       = IChannel::VERSION
  gem.authors       = ["Robert Gleeson"]
  gem.email         = ["rob@flowof.info"]
  gem.description   = %q{A modern and easy-to-use interprocess communication 
    primitive.}
  gem.summary       = gem.description
  gem.homepage      = "https://github.com/robgleeson/ichannel"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
