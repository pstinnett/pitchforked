set :stages, %w(production staging)
require 'capistrano/ext/multistage'
 
server "173.203.196.36", :app, :web, :db, :primary => true
 
set :user, 'root'
set :keep_releases, 3 
set :repository,  "git@github.com:pstinnett/pitchforked.git" # replace neerajdotname with your github username
set :use_sudo, false
set :scm, :git
set :deploy_via, :copy
set :branch, "master"
# this will make sure that capistrano checks out the submodules if any
set :git_enable_submodules, 1
 
set(:application) { "pitchforked_#{stage}" } # replace gitlearn with your application name
set (:deploy_to) { "/srv/www/apps/#{application}" }
set :copy_remote_dir, "/srv/www/apps/tmp"
 
# source: http://tomcopeland.blogs.com/juniordeveloper/2008/05/mod_rails-and-c.html
namespace :deploy do
  desc "Restarting mod_rails with restart.txt"
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{current_path}/tmp/restart.txt"
  end
 
  [:start, :stop].each do |t|
    desc "#{t} task is a no-op with mod_rails"
    task t, :roles => :app do ; end
  end
  
  desc "invoke the db migration"
  task:migrate, :roles => :app do
    send(run_method, "cd #{current_path} && rake db:migrate RAILS_ENV=#{stage} ")     
  end
  
end