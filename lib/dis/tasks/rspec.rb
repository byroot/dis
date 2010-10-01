module Dis
  module Tasks
    
    class Rspec < Dis::Tasks::Rake
      
      def perform!
        stdout = super
        last_build_successfull = store[:last_build_successful]
        store[:last_build_successful] = $?.success?
        
        if $?.success?
          build_fixed_message unless last_build_successful
        else
          stdout
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