Dis.integrate(:osdb) do
  repository :git, :url => 'git@github.com:byroot/ruby-osdb.git'
  task :rspec
  notification :mail, :to => %w(jean.boussier@gmail.com)
end