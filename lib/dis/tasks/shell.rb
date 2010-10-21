module Dis
  module Tasks
    
    class Shell < Dis::Tasks::Base
      
      include Dis::Tools::Shell
      
      def command
        raise NotImplementedError
      end
      
      def run!
        cd @project.source_path do
          stdout = execute! command
          build_report($?, stdout)
        end
      end
      
      def build_report(status, stdout)
        super(status.success? ? success_title : failure_title, stdout)
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