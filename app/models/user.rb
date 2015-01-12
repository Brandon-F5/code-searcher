class User < ActiveRecord::Base
  
  validates_presence_of :gh_uid
    

end
