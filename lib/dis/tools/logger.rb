module Dis
  module Tools
    class Logger
      
      attr_reader :project
      
      def initialize(project)
        @project = project
        @logger = ActiveSupport::BufferedLogger.new(log_file, Dis::Config.log_level)
      end
      
      %w(debug info warn error fatal).each do |method|
        class_eval %{
          def #{method}(*args)
            @logger.#{method}("[\#{timestamp}][#{method}] \#{args.join ''}")
          end
        }
      end
      
      def timestamp
        Time.now.strftime('%Y-%m-%d %H:%M:%S')
      end
      
      def log_file
        Dis::Config.log_directory == '-' ? STDOUT : File.join(log_path, "#{project.name}.log")
      end
      
      def log_path
        @log_path ||= returning Dis::Config.log_directory do |path|
          FileUtils.mkdir_p path
        end
      end
      
      module Delegation
        
        delegate :debug, :info, :warn, :error, :fatal, :to => :project
        
      end
      
    end
  end
end