require 'bundler'
Bundler.require

require_relative 'models/food'
require_relative 'models/order'
require_relative 'models/party'



# SETUP: CONNECTION
ActiveRecord::Base.establish_connection(
  :adapter  => "postgresql",
  :database => "restaurant_db"
)

# HELPERS
require_relative 'helpers/link_helper'
require_relative 'helpers/form_helper'
helpers ActiveSupport::Inflector


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
	if food.valid?
		redirect "/foods/#{food.id}"
	else
		@errors = food.errors.full_messages
		erb :'foods/new'
	end
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
	binding.pry
	party = Party.find(params[:id])
	party.update(params[:party])
  redirect "/parties/#{party.id}"
end

get '/parties/:id' do
	@party = Party.find(params[:id])
	@foods = Food.all
	@orders = Order.all
	erb :'parties/show'
end

delete '/parties/:id' do
	Party.destroy(params[:id])
	redirect "/parties"
end


# ORDERS

post '/orders' do
	order = Order.create(params[:order])
	redirect "/parties/#{order.party_id}"
end

# patch '/orders/:id' do
# 	redirect "/parties/#{}"
# end

delete '/orders/:id' do
	party_id = Order.where(id: params[:id]).map{|c| c[:party_id]}.join
	Order.destroy(params[:id])
	redirect "/parties/#{party_id}"
end

get '/parties/:id/receipt' do
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



