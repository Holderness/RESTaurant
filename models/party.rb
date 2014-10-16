
# MANY
class Party < ActiveRecord::Base
	has_many(:orders)
	has_many(:foods, :through => :orders)

	# validates_inclusion_of :paid, :in => [true, false]

end