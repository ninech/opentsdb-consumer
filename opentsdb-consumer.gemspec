# -*- encoding: utf-8 -*-
#
$LOAD_PATH.push File.expand_path('../lib', __FILE__)

Gem::Specification.new do |s|
  s.name        = 'opentsdb-consumer'
  s.version     = File.read(File.expand_path('../VERSION', __FILE__)).strip
  s.authors     = ['Philippe Hassig']
  s.email       = ['phil@nine.ch']
  s.homepage    = 'http://github.com/ninech/'
  s.license     = 'MIT'
  s.summary     = 'Client library to consume metrics from OpenTSDB'
  s.description = 'Client library to consume metrics from OpenTSDB'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }
  s.require_paths = ['lib']

  s.add_runtime_dependency 'excon', '~> 0.45.0'

  s.add_development_dependency 'rspec', '~> 3.5', '>= 3.5.0'
  s.add_development_dependency 'rake', '~> 10.0'
  s.add_development_dependency 'rack', '~> 1' # Remove this dependency when using ruby 2.2.2+
  s.add_development_dependency 'jeweler', '~> 2.0.1'
  s.add_development_dependency 'rdoc', '~> 3.12'
  s.add_development_dependency 'bundler', '~> 1.0'
  s.add_development_dependency 'pry', '~> 0'
  s.add_development_dependency 'coveralls', '~> 0'
end
