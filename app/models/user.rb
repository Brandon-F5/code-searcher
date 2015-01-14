class User < ActiveRecord::Base
  
  validates_presence_of :gh_uid
  
  def self.find_or_create_user_from_auth_hash(a_hash)
    u = User.find_by_gh_uid(a_hash['uid'])
    if(u == nil)
      u = User.new(nickname: a_hash['info']['nickname'], gh_uid: a_hash['uid'], image_url: a_hash['info']['image'], auth_token: a_hash['credentials']['token'], name: a_hash['info']['name'])
      if(u.save == false)
        u = nil
      end
    end
    u    
  end
  
  def display_name
    ds = (self.nickname != nil) ? self.nickname : "Unknown"
    ds = self.name unless self.name == nil
    ds
  end  

end
