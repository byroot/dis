module Dis
  module Notifiers
  
    class << self
    
      def find(name)
        const_get(name.to_s.camelize)
      end
    
    end
  
    class Base
      
      include Dis::Tools::Logger::Delegation
      
      attr_reader :project, :options
      
      def initialize(project, options={})
        @project = project
        @options = options
      end
      
      def deliver!(report)
        raise NotImplementedError
      end
      
    end
  
    Dir[File.dirname(__FILE__) + '/notifiers/*'].each do |notifier|
      autoload File.basename(notifier, '.rb').camelize, File.expand_path(notifier)
    end
  
  end
end