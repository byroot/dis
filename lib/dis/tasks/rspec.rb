module Dis
  module Tasks
    
    class Rspec < Dis::Tasks::Rake
      
      include Dis::Tasks::NotifyOnce
      
      def tasks
        %w(spec)
      end
      
    end
    
  end
end