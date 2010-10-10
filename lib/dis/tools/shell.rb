module Dis
  module Tools
    module Shell
      
      def execute!(command)
        returning %x{#{command} 2>&1 } do |stdout|
          debug command
          debug "exitstatus: #{$?.exitstatus}"
          debug stdout
        end
      end
      
      def cd(path)
        current_path = Dir.pwd
        Dir.chdir(path)
        debug "in #{path}"
        yield
      ensure
        Dir.chdir(current_path)
      end
      
    end
  end
end