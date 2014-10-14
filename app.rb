require 'bundler'
Bundler.require

require_relative 'models/food'
require_relative 'models/tag'
require_relative 'models/comment'



# SETUP: CONNECTION
ActiveRecord::Base.establish_connection(
  :adapter  => "postgresql",
  :database => "RESTaurant_db"
)


# MAIN MENU

get '/' do
	erb :index
end


# FOOD

get '/foods' do
	@foods = 
	erb :'foods/index'
end

get '/foods/:id' do
	erb :'foods/show'
end

get '/foods/new' do
	erb :'foods/new'
end

post '/foods' do
	redirect 'foods/:id'
end 

get '/foods/:id' do
	erb :'foods/edit'
end

patch '/foods/:id' do
  redirect 'foods/:id'
end

delete '/foods/:id' do
	redirect '/foods'
end


# PARTIES

get '/parties' do
	erb :'parties/index'
end

get '/parties/:id' do
	erb :'parties/show'
end

get '/parties/new' do
	erb :'parties/new'
end

post '/parties' do
	redirect 'parties/:id'
end 

get '/parties/:id' do
	erb :'parties/edit'
end

patch '/parties/:id' do
  redirect 'parties/:id'
end

delete '/parties/:id' do
	redirect '/parties'
end


# ORDERS
