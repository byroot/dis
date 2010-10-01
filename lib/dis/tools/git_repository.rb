module Dis
  module Tools
    class GitRepository
      
      # MAYBE: Use a real Git library
      
      include Dis::Tools::Shell
      
      def initialize(url, path='.', options={})
        @url = url
        @path = path
        @git_dir = File.join(path, '.git')
      end
      
      def exist?
        File.exist?(@git_dir)
      end
      
      def git!(command)
        cd(@path){ execute!("git #{command}") }
      end
      
      def clone!(branch='master')
        execute!("git clone #{@url} #{@path} --branch #{branch}")
      end
      
      def pull_rebase!(branch='master')
        git!("pull --rebase #{@url} #{branch}")
      end
      
      def head
        git!('log -n 1')
      end
      
      def last_commit
        head.match(/^commit (\w+)$/)
        $1
      end
      
    end
  end
end