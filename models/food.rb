
class Food < ActiveRecord::Base
	has_many :orders 
	has_many :parties, :through => :orders 
	has_many :users, :through => :orders

	validates :name, confirmation: true, uniqueness: true

end