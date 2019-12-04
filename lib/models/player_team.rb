class PlayerTeam < ActiveRecord::Base

    belongs_to :players
    belongs_to :fantasy_teams

end 