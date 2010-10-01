module Dis
  module Tools
    
  end
end

Dir[File.dirname(__FILE__) + '/tools/*.rb'].each{ |f| require File.expand_path(f) }