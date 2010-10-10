module Dis
  module Tools
    Dir[File.dirname(__FILE__) + '/tools/*.rb'].each do |f|
      autoload File.basename(f, '.rb').camelize, f
    end
  end
end
