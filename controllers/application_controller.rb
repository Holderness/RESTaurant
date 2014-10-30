
class ApplicationController < Sinatra::Base
	helpers Sinatra::AuthenticationHelper
	helpers Sinatra::FormHelper
	helpers Sinatra::LinkHelper
	helpers ActiveSupport::Inflector

  require_relative "./../connection"

  set :views, File.expand_path('../../views', __FILE__)
  set :public_folder, File.expand_path('../../public', __FILE__)

  enable :sessions
  enable :method_override

  get '/' do
	  erb :index
  end

  get '/login' do
		erb :'sessions/login'
	end

	get '/console' do 
	  binding.pry
  end

end