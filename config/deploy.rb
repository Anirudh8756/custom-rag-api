# config valid for current version and patch releases of Capistrano
lock "~> 3.19.1"

set :application, "custom-rag-api"
set :repo_url, "git@github.com:Anirudh8756/custom-rag-api.git"
append :linked_files, 'config/master.key'

# Default value for linked_dirs is []
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system", "vendor", "storage"

# Default value for default_env is {}
set :default_env, { path: "/opt/ruby/bin:$PATH" }
set :keep_releases, 5


#If you want to restart using `touch tmp/restart.txt`, add this to your config/deploy.rb:

#set :passenger_restart_with_touch, true

#If you want to restart using `passenger-config restart-app`, add this to your config/deploy.rb:

set :passenger_restart_with_touch, false # Note that `nil` is NOT the same as `false` here

#If you don't set `:passenger_restart_with_touch`, capistrano-passenger will check what version of passenger you are running and use `passenger-config restart-app` if it is available in that version.
