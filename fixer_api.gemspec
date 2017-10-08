$LOAD_PATH.push File.expand_path('../lib', __FILE__)

require 'fixer_api/version'

Gem::Specification.new do |s|
  s.name          = 'fixer_api'
  s.version       = FixerApi::VERSION
  s.date          = '2017-10-08'
  s.summary       = 'Gem fixer.io API'
  s.description   = 'Gem allows you to use fixer.io API for fetching current and historical foreign exchange
    rates published by the European Central Bank'
  s.authors       = ['Mike Andrianov']
  s.email         = 'mikeandrianov@gmail.com'
  s.files         = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']
  s.require_paths = ['lib']
  s.license       = 'MIT'
end
