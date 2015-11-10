# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-
# stub: opentsdb-consumer 0.1.1 ruby lib

Gem::Specification.new do |s|
  s.name = "opentsdb-consumer"
  s.version = "0.1.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Philippe H\u{e4}ssig"]
  s.date = "2015-11-10"
  s.description = "Client library to consume metrics from OpenTSDB"
  s.email = "phil@nine.ch"
  s.executables = ["opentsdb-consumer"]
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.md"
  ]
  s.files = [
    ".document",
    ".rspec",
    ".travis.yml",
    "Gemfile",
    "Gemfile.lock",
    "LICENSE.txt",
    "README.md",
    "Rakefile",
    "VERSION",
    "bin/opentsdb-consumer",
    "lib/opentsdb-consumer.rb",
    "lib/opentsdb-consumer/client.rb",
    "lib/opentsdb-consumer/errors.rb",
    "lib/opentsdb-consumer/metric.rb",
    "lib/opentsdb-consumer/query.rb",
    "lib/opentsdb-consumer/result.rb",
    "opentsdb-consumer.gemspec",
    "spec/opentsdb-consumer/client_spec.rb",
    "spec/opentsdb-consumer/metric_spec.rb",
    "spec/opentsdb-consumer/query_spec.rb",
    "spec/opentsdb-consumer/result_spec.rb",
    "spec/spec_helper.rb"
  ]
  s.homepage = "http://github.com/ninech/opentsdb-consumer"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.4.5.1"
  s.summary = "Client library to consume metrics from OpenTSDB"

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<excon>, ["~> 0.45.0"])
      s.add_development_dependency(%q<rspec>, ["~> 3.3.0"])
      s.add_development_dependency(%q<rdoc>, ["~> 3.12"])
      s.add_development_dependency(%q<bundler>, ["~> 1.0"])
      s.add_development_dependency(%q<jeweler>, ["~> 2.0.1"])
      s.add_development_dependency(%q<byebug>, [">= 0"])
      s.add_development_dependency(%q<pry>, [">= 0"])
      s.add_development_dependency(%q<coveralls>, [">= 0"])
    else
      s.add_dependency(%q<excon>, ["~> 0.45.0"])
      s.add_dependency(%q<rspec>, ["~> 3.3.0"])
      s.add_dependency(%q<rdoc>, ["~> 3.12"])
      s.add_dependency(%q<bundler>, ["~> 1.0"])
      s.add_dependency(%q<jeweler>, ["~> 2.0.1"])
      s.add_dependency(%q<byebug>, [">= 0"])
      s.add_dependency(%q<pry>, [">= 0"])
      s.add_dependency(%q<coveralls>, [">= 0"])
    end
  else
    s.add_dependency(%q<excon>, ["~> 0.45.0"])
    s.add_dependency(%q<rspec>, ["~> 3.3.0"])
    s.add_dependency(%q<rdoc>, ["~> 3.12"])
    s.add_dependency(%q<bundler>, ["~> 1.0"])
    s.add_dependency(%q<jeweler>, ["~> 2.0.1"])
    s.add_dependency(%q<byebug>, [">= 0"])
    s.add_dependency(%q<pry>, [">= 0"])
    s.add_dependency(%q<coveralls>, [">= 0"])
  end
end

