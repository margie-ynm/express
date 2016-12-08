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

# CREATE    POST /cities (in progress)
# READ ALL  GET  /cities (done)
# READ ONE  GET /cities/:id
# UPDATE    PATCH /cities/:id
# DELETE    DELETE /cities/:id

get('/cities') do
  @cities = City.all
  erb(:cities_list)
end

post('/cities') do
  name = params.fetch('new-city-name')
  City.new({:name => name}).save
  redirect('/cities')
end
