require('sinatra')
require('sinatra/reloader')
require('./lib/city')
require('./lib/train')
also_reload('lib/**/*.rb')
require('pg')

set :public_folder, 'public'


DB = PG.connect({:dbname => 'express'}) # rescue require('./db_init.rb')

get('/') do
  erb(:index)
end
