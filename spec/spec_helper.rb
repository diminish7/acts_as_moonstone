require 'rubygems'
require 'active_record'
require 'active_support'
here = File.dirname(__FILE__)
RAILS_ROOT = File.join(here, "rails")
require File.join(here, "..", 'init')
require File.join(here, "setup")

def clean_index
  Acts::Moonstone::ENGINE.close
  Dir[File.join(File.dirname(__FILE__), "rails", "index", "*")].each { |fname| File.delete(fname) }
end