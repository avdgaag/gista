# -*- encoding: utf-8 -*-
require File.expand_path('../lib/gista/version', __FILE__)

Gem::Specification.new do |s|
  # Metadata
  s.name        = 'gista'
  s.version     = Gista::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ['Arjan van der Gaag']
  s.email       = %q{arjan@arjanvandergaag.nl}
  s.description = %q{create gists from the command line}
  s.homepage    = %q{http://avdgaag.github.com/gista}
  s.summary     = <<-EOS
Gista is a very simple command-line program and Ruby library for creating
Gists. As a stand-alone program, it can create a new gist from files listed as
arguments, or by reading from STDIN.
EOS

  # Files
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ['lib']

  # Rdoc
  s.rdoc_options = ['--charset=UTF-8']
  s.extra_rdoc_files = [
     'LICENSE',
     'README.md',
     'HISTORY.md'
  ]

  # Dependencies
  s.add_development_dependency 'yard',     '~> 0.8'
  s.add_development_dependency 'fakeweb',  '~> 1.3'
  s.add_development_dependency 'rspec',    '~> 2.11'
  s.add_development_dependency 'rake',     '~> 0.9'
  s.add_development_dependency 'kramdown'
end

