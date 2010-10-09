module Dis
  module Tools
    class Lock
      
      attr_reader :project
      
      def initialize(project)
        @project = project
      end
      
      def acquire!
        unless File.exist?(lock_path)
        File.open(lock_path, 'w+') { |f| f << $$ }
          begin
            yield
          ensure
            File.unlink(lock_path) rescue nil
          end
        else # TODO: real logger
          puts "Project #{project.name} already in integration by another process (#{lock_path})"
        end
      end
      
      def lock_path
        @lock_path ||= "/tmp/dis-integrate-#{project.name}"
      end
      
    end
  end
end