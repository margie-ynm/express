require('sinatra')
require('sinatra/reloader')
require('./lib/city')
require('./lib/train')
also_reload('lib/**/*.rb')
require('pg')

set :public_folder, 'public'

puts DB rescue DB = PG.connect({:dbname => 'express'}) # rescue require('./db_init.rb')

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
  erb(:city_list)
end

post('/cities') do
  name = params.fetch('new-city-name')
  City.new({:name => name}).save
  redirect('/cities')
end

get('/cities/:id') do
  #fetch the id, find the city with that id, and then assign @city to that city.
  @city = City.find(params.fetch('id').to_i)
  erb(:city_detail)
end

get('/cities/:id/edit') do
  @city = City.find(params.fetch('id').to_i)
  erb(:city_update)
end

patch('/cities/:id') do
  @city = City.find(params.fetch('id').to_i)
  @city.update({:name => params.fetch('city-name')})
  redirect "/cities/#{params.fetch('id')}"
end
