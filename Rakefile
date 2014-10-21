require 'bundler'
Bundler.require

require 'sinatra/activerecord/rake'

ActiveRecord::Base.establish_connection({
  adapter: 'postgresql',
  database: 'restaurant_db'
})


namespace :db do
  desc "Create restaurant_db database"
  task :create_db do
    conn = PG::Connection.open()
    conn.exec('CREATE DATABASE restaurant_db;')
    conn.close
  end


  desc "Drop restaurant_db database"
  task :drop_db do
    conn = PG::Connection.open()
    conn.exec('DROP DATABASE restaurant_db;')
    conn.close
  end

  desc "Create junk data"
  task :junk_data do

  	require_relative 'models/food'
    require_relative 'models/party'
    require_relative 'models/order'

    number = [*1..20]
    paid = [true, false]


    Food.create({name: 'Chilled Garbanzo Beans', cuisine_type: 'Beans', price: number.sample, allergens: 'rodents'})
    Food.create({name: 'Steve\'s Chili Con Carnivals', cuisine_type: 'tree bark', price: number.sample, allergens: 'trousers'})
    Food.create({name: 'Gilp', cuisine_type: 'Beans', price: number.sample, allergens: 'Special Somethin\' Somethin\''})
    Food.create({name: 'Baynard Mayonaise Pudding Pops', cuisine_type: 'Flarps', price: number.sample, allergens: 'Gant'})

    Party.create({table_no: number.sample, guest_no: number.sample, paid: paid.sample, dufresnes: false})
    Party.create({table_no: number.sample, guest_no: number.sample, paid: paid.sample, dufresnes: false})
    Party.create({table_no: number.sample, guest_no: number.sample, paid: paid.sample, dufresnes: false})
    Party.create({table_no: number.sample, guest_no: number.sample, paid: paid.sample, dufresnes: false})
    Party.create({table_no: number.sample, guest_no: number.sample, paid: paid.sample, dufresnes: false})
    
    parties = Party.all
    foods = Food.all

    parties.each do |party|
      party.guest_no.times do
        Order.create({party: party, food: foods.sample}) if [true, false].sample
      end
    end


  end


end