module Dis
  module Fetchers
    
    class << self
      
      def find(name)
        const_get(name.to_s.camelize)
      end
      
    end
    
    class Base
      
      def initialize(project, options={})
        @project = project
        @options = options
      end
      
      def fetch!
        raise NotImplementedError
      end
      
    end
    
    Dir[File.dirname(__FILE__) + '/fetchers/*'].each do |fetcher|
      autoload File.basename(fetcher, '.rb').camelize, File.expand_path(fetcher)
    end
    
  end
end

