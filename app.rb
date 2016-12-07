require('sinatra')
require('sinatra/reloader')
require('./lib/city')
require('./lib/train')
also_reload('lib/**/*.rb')

set :public_folder, 'public'

get('/') do
  erb(:index)
end
