class AddLeagueToFantasyTeam < ActiveRecord::Migration[6.0]
  def change
    add_reference :fantasy_teams, :league, index:true 
  end
end
