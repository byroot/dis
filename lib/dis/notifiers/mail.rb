require 'tempfile'

module Dis
  module Notifiers
    
    class Mail < Dis::Notifiers::Base
      
      include Dis::Tools::Shell
      
      def deliver!(report)
        Tempfile.open('mail').tap do |file|
          file.write(report.body)
          file.close
          execute! %Q{ mail -s '#{report.title}' #{options[:to].join(' ')} < '#{file.path}' }
        end
      end
      
    end
    
  end
end
