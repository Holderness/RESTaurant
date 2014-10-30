class UsersController < ApplicationController

	get '/new' do
		erb :'users/new'
	end

	post '/' do
		user = User.new(params[:user])
		user.password = params[:password]
		user.save!
    redirect '/login'  # Normally we would direct to the show page
  end

end