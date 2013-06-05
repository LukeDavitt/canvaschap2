require "capistrano/ext/multistage"
set application:"canvaschap2"
set :scm, :git
set :repository, "git@github.com:LukeDavitt/canvaschap2.git"
set :scm_passphrase, ""

set :user, "lukedavitt"

set :stages, ["staging", "production"]
set :default_stage, "staging"

server "99.22.23.46", :app, :web, :db, :primary => true
set :deploy_to, "/home/lukedavitt/canvaschap2"

