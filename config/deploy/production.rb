role :app, %w{deployer@95.217.211.178}
role :web, %w{deployer@95.217.211.178}
role :db,  %w{deployer@95.217.211.178}

set :branch, "main"
set :rbenv_ruby, "3.3.3"
set :deploy_to, "/home/deployer/app/custom-reg-api"
