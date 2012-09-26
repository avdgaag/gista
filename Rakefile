#!/usr/bin/env rake

require 'bundler'
Bundler::GemHelper.install_tasks
Bundler.setup

require 'rspec/core/rake_task'
require 'yard'

desc 'Default: run specs.'
task default: :spec

desc 'Run specs'
RSpec::Core::RakeTask.new

desc 'Generate API docs'
YARD::Rake::YardocTask.new
