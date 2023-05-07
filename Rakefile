# Rakefile
require 'sinatra/activerecord/rake'
require './app'

namespace :db do
  task :load_config do
    require 'yaml'
    ActiveRecord::Base.configurations = YAML.load_file('config/database.yml')
  end
end
