module Dis
  module Tasks
    
    module NotifyOnce
      
      def self.included(base)
        base.persistant_attr_accessor :last_build_successful
      end
      
      def build_report(status, stdout)
        previous_build_successful, self.last_build_successful = last_build_successful, status.success?
        if !Dis::Config.force && last_build_successful && previous_build_successful
          return
        end
        if last_build_successful && !previous_build_successful
          super(build_fixed_message, stdout)
        else
          super
        end
      end
      
      def build_fixed_message
        "The build of #{project.name} has been fixed"
      end
      
      def tasks
        %w(spec)
      end
      
    end
    
  end
end