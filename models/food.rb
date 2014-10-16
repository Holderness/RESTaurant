
# MANY
class Food < ActiveRecord::Base
	has_many(:orders)
	has_many(:parties, :through => :orders)

	validates :name, confirmation: true, uniqueness: true

end