
# IN CONFIG.RU
# require './app'
# run Sinatra::Application


# require 'bundler'
# Bundler.require

# Dir.glob('./{helpers,models,controllers}/*.rb').each do |file|
#   require file
#   puts "required #{file}"
# end


# map('/users'){ run UsersController }
# map('/sessions'){ run SessionsController }
# map('/'){ run ApplicationController }




# require 'bundler'
# Bundler.require

# require './connection'

# require './models/food'
# require './models/order'
# require './models/party'
# require './models/user'


# # SESSIONS
# enable :sessions

# # HELPERS
# require './helpers/link_helper'
# require './helpers/form_helper'
# require './helpers/authentication_helper'
# helpers ActiveSupport::Inflector


# # MAIN MENU

# get '/' do
# 	erb :index
# end


# SIGN UP

# get '/users/new' do
#   erb :'users/new'
# end

# post '/users' do
#   user = User.new(params[:user])
#   user.password = params[:password]
#   user.save!
#   redirect '/'  # Normally we would direct to the show page
# end


# LOGIN

# get '/login' do
#   erb :'sessions/login'
# end

# post '/sessions' do
#   redirect '/' unless user = User.find_by({username: params[:username]})
#   if user.password == params[:password]
#     session[:current_user] = user.id
#     redirect '/' # May redirect to... show
#   else
#     redirect '/' # May redirect to log-in
#   end
# end

# delete '/sessions' do
#   session[:current_user] = nil
#   redirect '/'
# end




# FOOD

get '/foods' do
	authenticate!
	@foods = Food.all
	erb :'foods/index'
end


get '/foods/new' do
	authenticate!
	erb :'foods/new'
end

post '/foods' do
	authenticate!
	food = Food.create(params[:food])
	if food.valid?
		redirect "/foods/#{food.id}"
	else
		@errors = food.errors.full_messages
		erb :'foods/new'
	end
end 

get '/foods/:id/edit' do
	authenticate!
	@food = Food.find(params[:id])
	erb :'foods/edit'
end

patch '/foods/:id' do
	authenticate!
	food = Food.find(params[:id])
	food.update(params[:food])
  redirect "/foods/#{food.id}"
end

get '/foods/:id' do
	authenticate!
	@food = Food.find(params[:id])
	erb :'foods/show'
end

delete '/foods/:id' do
	authenticate!
	Food.destroy(params[:id])
	redirect "/foods"
end


# PARTIES

get '/parties' do
	authenticate!
	@parties = Party.all
	erb :'parties/index'
end

get '/parties/new' do
	authenticate!
	erb :'parties/new'
end

post '/parties' do
	authenticate!
	party = Party.create(params[:party])
	redirect "/parties/#{party.id}"
end 

get '/parties/:id/edit' do
	authenticate!
	@party = Party.find(params[:id])
	erb :'parties/edit'
end

patch '/parties/:id' do
	authenticate!
	binding.pry
	party = Party.find(params[:id])
	party.update(params[:party])
  redirect "/parties/#{party.id}"
end

get '/parties/:id' do
	authenticate!
	@party = Party.find(params[:id])
	@foods = Food.all
	@orders = Order.all
	erb :'parties/show'
end

delete '/parties/:id' do
	authenticate!
	Party.destroy(params[:id])
	redirect "/parties"
end


# ORDERS

post '/orders' do
	authenticate!
	order = Order.create(params[:order])
	redirect "/parties/#{order.party_id}"
end

# patch '/orders/:id' do
# 	redirect "/parties/#{}"
# end

delete '/orders/:id' do
	authenticate!
	party_id = Order.where(id: params[:id]).map{|c| c[:party_id]}.join
	Order.destroy(params[:id])
	redirect "/parties/#{party_id}"
end

get '/parties/:id/receipt' do
	authenticate!
	@party = Party.find(params[:id])
	@foods = Food.all
	@orders = Order.all
	write_receipt
	erb :'parties/receipt'
end

def write_receipt
	price_total = 0
	File.open('receipts.txt', 'a+') do |f|
	f << "-" * 52 + "\n"
	f << "Table #{ @party.table_no } ORDER:" + "\n"
	@orders.select do |order|
		food = Food.where(id: order[:food_id]).map{|sql_column| sql_column[:name]}.join
	  price = Food.where(id: order[:food_id]).map{|sql_column| sql_column[:price]}.join.to_i
    if order[:party_id] == @party.id
    	f << " #{ food } - #{ price }" + "\n"
			price_total += price
		end
	end
  f << "-" * 52 + "\n"
  f << "Balace Due: #{'%.2f' % price_total}" + "\n"
  f << "-" * 52 + "\n\n\n"
  end
end









get '/console' do 
	binding.pry
end
# patch '/parties/:id/checkout' do

# 	redirect "/parties"
# end



