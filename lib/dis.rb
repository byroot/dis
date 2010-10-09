require 'rubygems'
require 'active_support'

module Dis
  BASE_PATH = File.expand_path(File.dirname(__FILE__))
  
  %w(config tools fetchers tasks project report notifiers).each do |f|
    autoload f.camelize, "#{Dis::BASE_PATH}/dis/#{f}.rb"
  end
  
  def self.integrate(name, &block)
    Dis::Project.new(name, &block).integrate!
  end
end

