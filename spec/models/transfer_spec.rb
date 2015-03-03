require 'rails_helper'

RSpec.describe Transfer, type: :model do

  describe "#update_balance" do

  	let(:user_2){ User.create(name: "Perensejo") }
	let(:user_1){ User.create(name: "Periquito") }

  	it "should update balance of sender and receiver when transfer is created" do

  		transfer = Transfer.new( sender: user_1,  receiver: user_2, amount: 500 )
  		transfer.save
  		transfer.reload
  		expect( user_1.balance ).to eq ( 49500 )
  		expect( user_2.balance ).to eq ( 50500 )

  	end

  	it "what happen if amount is negative?" do

  		transfer = Transfer.new( sender: user_1,  receiver: user_2, amount: -500 )
  		transfer.save
  		expect( user_1.reload.balance ).to eq ( 50000 )
  		expect( user_2.reload.balance ).to eq ( 50000 )

  	end

	it "should update balance of sender and receiver when transfer is updated" do

  		transfer = Transfer.create( sender: user_1,  receiver: user_2, amount: 500 )
  		transfer.update( amount: 1000 )
  		expect( user_1.reload.balance ).to eq ( 49000 )
  		expect( user_2.reload.balance ).to eq ( 51000 )


 	end

 	it "should update balance of sender and receiver when transfer is destroyed" do

  		transfer = Transfer.create( sender: user_1,  receiver: user_2, amount: 500 )
  		transfer.destroy
  		expect( user_1.reload.balance ).to eq ( 50000 )
  		expect( user_2.reload.balance ).to eq ( 50000 )


 	end		

 end

end
