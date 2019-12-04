class User < ActiveRecord::Base

    has_many :league_users
    has_many :leagues, through: :league_users


    
end 