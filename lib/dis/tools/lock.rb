module Dis
  module Tools
    class Lock
      
      attr_reader :project
      
      include Dis::Tools::Logger::Delegation
      
      def initialize(project)
        @project = project
      end
      
      def acquire!
        unless File.exist?(lock_path)
        File.open(lock_path, 'w+') { |f| f << $$ }
          begin
            info "Lock acquired (#{lock_path})"
            yield
          ensure
            File.unlink(lock_path) rescue nil
            info "Lock released (#{lock_path})"
          end
        else
          error "Project #{project.name} already in integration by another process (#{lock_path})"
        end
      end
      
      def lock_path
        @lock_path ||= "/tmp/dis-integrate-#{project.name}"
      end
      
    end
  end
end