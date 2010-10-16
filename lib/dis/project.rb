require 'fileutils'

module Dis
  class Project
    
    include Dis::Tools::Shell
    
    delegate :debug, :info, :warn, :error, :fatal, :to => :logger
    
    attr_reader :name, :notifier
    
    def initialize(name, &block)
      @name = name.to_s
      FileUtils.mkdir_p [var_path, source_path]
      instance_eval(&block)
    end
    
    def repository(fetcher=nil, *args)
      if fetcher.present?
        @repository = Dis::Fetchers.find(fetcher).new(self, *args)
      else
        @repository
      end
    end
    
    def notification(notifier, *args)
      @notifier = Dis::Notifiers.find(notifier).new(self, *args)
    end
    
    def tasks
      @tasks ||= []
    end
    
    def task(kind, *args)
      tasks << Dis::Tasks.find(kind).new(self, *args)
    end
    
    def integrate!
      lock.acquire! do
        if repository.fetch! or Dis::Config.force? # new commits
          tasks.each do |task|
            info "perform #{task.identifier}"
            notify!(task.perform!)
            task.finalize!
          end
        else
          info "No changes found since last run, break."
        end
      end
    end
    
    def lock
      @lock ||= Dis::Tools::Lock.new(self)
    end
    
    def logger
      @logger ||= Dis::Tools::Logger.new(self)
    end
    
    def notify!(report)
      notifier.deliver!(report)
    end
    
    def data_path
      File.join(Dis::Config.working_directory, 'data', name)
    end
    
    def source_path
      File.join(data_path, 'src')
    end
    
    def var_path
      File.join(data_path, 'var')
    end
    
  end
end