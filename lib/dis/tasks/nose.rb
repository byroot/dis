module Dis
  module Tasks
    
    class Nose < Dis::Tasks::Shell
      
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
      
    end
    
  end
end