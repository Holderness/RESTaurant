class OrdersController < ApplicationController

	post '/' do
		authenticate!
		order = Order.create(params[:order])
		redirect "/parties/#{order.party_id}"
	end

	delete '/:id' do
		authenticate!
		party_id = Order.where(id: params[:id]).map{|c| c[:party_id]}.join
		Order.destroy(params[:id])
		redirect "/parties/#{party_id}"
	end

end