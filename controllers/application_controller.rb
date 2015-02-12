
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

  after { ActiveRecord::Base.connection.close }

  get '/' do
    erb :index
  end

  get '/login' do
    erb :'sessions/login'
  end
 
  get '/console' do 
    binding.pry
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

end