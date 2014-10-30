
class ApplicationController < Sinatra::Base
	helpers Sinatra::AuthenticationHelper

  require_relative "./../connection"

  set :views, File.expand_path('../../views', __FILE__)
  set :public_folder, File.expand_path('../../public', __FILE__)

  enable :sessions, :method_override

  get '/' do
	  erb :index
  end

  get '/login' do
		erb :'sessions/login'
	end


end