module Dis
  module Tasks
  
    class << self
    
      def find(name)
        const_get(name.to_s.camelize)
      end
      
    end
  
    class Base
      
      include Dis::Tools::Logger::Delegation
      
      class << self
        
        def persistant_attr_accessor(sym)
          class_eval <<-EOS
          
          def #{sym}
            store[:#{sym}]
          end
          
          def #{sym}?
            store[:#{sym}].present?
          end
          
          def #{sym}=(value)
            store[:#{sym}] = value
          end
          
          EOS
        end
        
      end
      
      attr_reader :project, :options
      
      def initialize(project, *flags)
        @project = project
        @options = flags.extract_options!.merge(Hash[flags.map{ |f| [f, true]}])
      end
      
      def perform!
        report = self.run!
        return report unless self.muted?
      end
      
      def run!
        raise NotImplementedError
      end
      
      def build_report(title, body)
        Dis::Report.new(title, body)
      end
      
      def muted?
        options[:muted].present?
      end
      
      def identifier # FIXME: identifier should be unique AND readable
        self.class.name.demodulize.underscore
      end
      
      def store_path
        File.join(project.var_path, "#{identifier}.yml")
      end
      
      def store
        @store ||= ((YAML.load_file(store_path) rescue nil) || {}).with_indifferent_access
      end
      
      def finalize!
        File.open(store_path, 'w+') do |file|
          YAML.dump(@store, file)
        end
      end
      
    end
  
    Dir[File.dirname(__FILE__) + '/tasks/*'].each do |task|
      autoload File.basename(task, '.rb').camelize, File.expand_path(task)
    end
  
  end
end