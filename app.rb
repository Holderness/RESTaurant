require 'bundler'
Bundler.require

require 'pry'

require_relative 'models/food'
require_relative 'models/order'
require_relative 'models/party'



# SETUP: CONNECTION
ActiveRecord::Base.establish_connection(
  :adapter  => "postgresql",
  :database => "restaurant_db"
)


# MAIN MENU

get '/' do
	erb :index
end


# FOOD

get '/foods' do
	@foods = Food.all
	erb :'foods/index'
end


get '/foods/new' do
	erb :'foods/new'
end

post '/foods' do
	food = Food.create(params[:food])
	redirect "/foods/#{food.id}"
end 

get '/foods/:id/edit' do
	@food = Food.find(params[:id])
	erb :'foods/edit'
end

patch '/foods/:id' do
	food = Food.find(params[:id])
	food.update(params[:food])
  redirect "/foods/#{food.id}"
end

get '/foods/:id' do
	@food = Food.find(params[:id])
	erb :'foods/show'
end

delete '/foods/:id' do
	Food.destroy(params[:id])
	redirect "/foods"
end


# PARTIES

get '/parties' do
	@parties = Party.all
	erb :'parties/index'
end

get '/parties/new' do
	erb :'parties/new'
end

post '/parties' do
	party = Party.create(params[:party])
	redirect "/parties/#{party.id}"
end 

get '/parties/:id/edit' do
	@party = Party.find(params[:id])
	erb :'parties/edit'
end

patch '/parties/:id' do
	party = Party.find(params[:id])
	party.update(params[:party])
  redirect "/parties/#{party.id}"
end

get '/parties/:id' do
	@party = Party.find(params[:id])
	@foods = Food.all
	erb :'parties/show'
end

delete '/parties/:id' do
	Party.destroy(params[:id])
	redirect "/parties"
end


# ORDERS

post '/orders' do
	party = Party.find(params[:party_id])
	food = Food.find(params[:food_id])
	party.foods << food
	redirect "/parties/#{party.id}"
end

patch '/orders/:id' do
	redirect "/parties/#{party.id}"
end

delete '/orders' do
	redirect "/parties/#{party.id}"
end

get '/parties/:id/receipt' do
	erb :receipt
end

patch '/parties/:id/checkout' do
	redirect "/parties"
end





