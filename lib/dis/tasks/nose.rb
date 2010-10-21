module Dis
  module Tasks
    
    class Nose < Dis::Tasks::Base
      
      include Dis::Tools::Shell
      include Dis::Tasks::NotifyOnce
      
      def command
        "nosetests #{command_options.join ' '}"
      end
      
      def command_options
        [coverage_options].flatten.compact
      end
      
      def coverage_options
        if coverage = options[:coverage]
          args = %w(--with-coverage)
          if coverage.is_a?(Hash) && coverage[:package]
            args << "--cover-package=#{[coverage[:package]].flatten.map(&:to_s).join(',')}"
          end
        end
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