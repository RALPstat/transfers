# == Schema Information
#
# Table name: transfers
#
#  id          :integer          not null, primary key
#  sender_id   :integer
#  receiver_id :integer
#  amount      :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Transfer < ActiveRecord::Base
	belongs_to :sender, class_name: :User
	belongs_to :receiver, class_name: :User

	validates :amount, numericality: { greater_than_or_equal_to: 0 }

	after_create :update_sender_and_receiver_balance
	after_update :update_sender_and_receiver_amount
	before_destroy :cancel_sender_and_receiver_transfer

	private
	def update_sender_and_receiver_balance
		sender = self.sender 
		receiver = self.receiver

		sender.balance = sender.balance - amount
		receiver.balance = receiver.balance + amount

		sender.save
		receiver.save
	end

	def update_sender_and_receiver_amount
		sender.balance = sender.balance - (self.amount - self.amount_was)
		receiver.balance = receiver.balance + (self.amount - self.amount_was)

		sender.save
		receiver.save
	end

	def cancel_sender_and_receiver_transfer
		sender.balance = sender.balance + (self.amount)
		receiver.balance = receiver.balance - (self.amount)

		sender.save
		receiver.save
	end
end
