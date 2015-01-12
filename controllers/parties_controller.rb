class PartiesController < ApplicationController

	get '/' do
		authenticate!
		@parties = Party.all
		erb :'parties/index'
	end

	get '/new' do
		authenticate!
		erb :'parties/new'
	end

	post '/' do
		authenticate!
		party = Party.create(params[:party])
		redirect "/parties/#{party.id}"
	end 

	patch '/:id' do
		party = Party.find(params[:id])
		party.update(params[:party])
		binding.pry
		redirect "/parties/#{party.id}"
	end


	get '/:id/edit' do
		@party = Party.find(params[:id])
		erb :'parties/edit'
	end




	get '/:id' do
		authenticate!
		@party = Party.find(params[:id])
		@foods = Food.all
		@orders = Order.all
		erb :'parties/show'
	end

	delete '/:id' do
		authenticate!
		Party.destroy(params[:id])
		redirect "/parties"
	end

	get '/:id/receipt' do
		authenticate!
		@party = Party.find(params[:id])
		@foods = Food.all
		@orders = Order.all
		write_receipt
		erb :'parties/receipt'
	end

end