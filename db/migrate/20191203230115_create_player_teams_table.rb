class CreatePlayerTeamsTable < ActiveRecord::Migration[6.0]
  def change
    create_table :player_teams do | t |
      t.references :player, foreign_key: true 
      t.references :fantasy_team, foreign_key: true
    end 
  end
end
