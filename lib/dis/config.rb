require 'optparse'

module Dis
  module Config
    
    class << self
      
      attr_accessor_with_default :working_directory, '/tmp/dis/'
      
      def parser
        @parser ||= OptionParser.new do |opts|
          opts.banner = "Usage: integrate [options] DESCRIPTION_FILE ..."
          opts.separator ''
          opts.separator "Main options:"
          opts.on '-d', '--working-directory DIR', "Directory where Dis will store fetched code, tasks status ... Default to /tmp/dis/" do |dir|
            Dis::Config.working_directory = dir
          end
          
        end
      end
      
      delegate :parse!, :to => :parser
      
    end
    
  end
end