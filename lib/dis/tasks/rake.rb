module Dis
  module Tasks
    
    class Rake < Dis::Tasks::Shell
      
      def tasks
        @tasks ||= [@options[:task] || @options[:tasks]].flatten
      end
      
      def command
        "rake #{tasks.join(' ')}"
      end

    end
    
  end
end