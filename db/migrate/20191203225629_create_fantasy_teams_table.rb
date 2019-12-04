class CreateFantasyTeamsTable < ActiveRecord::Migration[6.0]
  def change
    create_table :fantasy_teams do | t |
      t.string :team_name
    end
  end
end
