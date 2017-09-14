set :application, "maropost_forum"
set :repository,  ""

set  :scm, :git
set  :user, "root"
set  :use_sudo, false
set  :deploy_via, :remote_cache
set  :branch, "master"
set  :deploy_to, "/srv/"
role :web, ""                          # Your HTTP server, Apache/etc
role :app, ""                          # This may be the same as your `Web` server
role :db,  "", :primary => true # This is where Rails migrations will run
set :env, 'production'
# if you want to clean up old releases on each deploy uncomment this:
after "deploy:restart", "deploy:cleanup"

after "deploy:cleanup", "custom:build"

namespace :custom do
  task :build do
    puts "==================Building======================" #Line 22
    run "bash --login -c 'cd #{deploy_to}/current && rvm use 1.9.3 && bundle check || bundle install --deployment --without development test'"
    run "bash --login -c 'cd #{deploy_to}/current && rvm use 1.9.3 && RAILS_ENV=#{env} RAILS_GROUPS=assets rake assets:precompile'"
  end
end
