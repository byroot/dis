Dis.integrate(:osdb) do
  repository :git, :url => 'git@github.com:byroot/ruby-osdb.git'
  task :rspec
  notification :mail, :to => [%x{git config user.email}]
end