# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string
#  balance    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class User < ActiveRecord::Base
	has_many :receive_transfers, foreign_key: :sender_id, class_name: :Transfer
	has_many :sent_transfers, foreign_key: :receiver_id, class_name: :Transfer
end
