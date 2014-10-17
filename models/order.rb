
class PartyHasntPaidValidator < ActiveModel::Validator
	def validate(order)
		if order.party.paid
			order.errors[:base] << "They already paid"
		end
	end
end

# JOIN
class Order < ActiveRecord::Base
	belongs_to(:food)
	belongs_to(:party)

	validates_with PartyHasntPaidValidator
end