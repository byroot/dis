module Dis
  module Tasks
    
    class Rake < Dis::Tasks::Base
      
      include Dis::Tools::Shell
      
      def tasks
        @tasks ||= [@options[:task] || @options[:tasks]].flatten
      end
      
      def command
        "rake #{tasks.join(' ')}"
      end
      
      def perform!
        cd @project.source_path do
          build_report(execute! command)
        end
      end
      
      def build_report(stdout)
        Dis::Report.new($?.success? ? success_title : failure_title, stdout) unless muted?
      end
      
      def success_title
        "#{command} executed successfully !"
      end
      
      def failure_title
        "#{command} failed !"
      end
      
    end
    
  end
end