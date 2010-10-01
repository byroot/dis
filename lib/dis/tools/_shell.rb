module Dis
  module Tools
    module Shell
      
      def execute!(command)
        %x{#{command} 2>&1 }
      end
      
      def cd(path)
        current_path = Dir.pwd
        Dir.chdir(path)
        yield
      ensure
        Dir.chdir(current_path)
      end
      
    end
  end
end