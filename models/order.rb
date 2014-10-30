
class PartyHasntPaidValidator < ActiveModel::Validator
	def validate(order)
		if order.party.paid
			order.errors[:base] << "They already paid"
		end
	end
end


class Order < ActiveRecord::Base
	belongs_to :food
	belongs_to :party
	belongs_to :user

	validates_with PartyHasntPaidValidator
end