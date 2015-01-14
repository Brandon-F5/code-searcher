require 'rails_helper'

RSpec.describe User, :type => :model do
  let!(:user) { FactoryGirl.build(:user, name: "Brandon", nickname: "SweetCode-GH", email: 'test@test.local', gh_uid: '123456789', auth_token: "987654321", image_url: "https://avatars.githubusercontent.com/u/5280814?v=3") }

  context '.gh_uid' do
    it 'cannot be nil' do
      user.gh_uid = nil
      user.save
      expect(user).to_not be_valid
    end
  end
  
  context '.display_name' do
    it 'cannot be nil' do
      expect(user.display_name).to_not eql(nil)
    end
    
    it 'returns name if present' do
      expect(user.display_name).to eql("Brandon")
    end
    
    it 'returns nickname if name is not present' do
      user.name = nil
      expect(user.display_name).to eql("SweetCode-GH")
    end
  end
  
  context '::find_or_create_user_from_auth_hash()' do
    info = {nickname: 'NewUser-GH', image: "https://avatars.githubusercontent.com/u/5280814?v=3", name: "Roger"}
    creds = {token: '123987654'}
    a_hash = {'uid' => '456789123', 'info' => info, 'credentials' => creds}
    new_user = User.find_or_create_user_from_auth_hash(a_hash) 
     
    it 'should_create_a_user_when_given_new_data' do
      expect(new_user).to_not eql(user)
    end
    
    it 'should_return_a_user_when_given_existing_data' do
      expect(User.find_or_create_user_from_auth_hash(a_hash)).to eql(new_user)
    end
    
  end
  
end
