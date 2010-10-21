Dis.integrate(:pysrt) do
  
  repository :git, :url => 'git@github.com:byroot/ruby-osdb.git'
  task :nose, :coverage => { :package => :pysrt }
  notification :mail, :to => [%x{git config user.email}]
  
end