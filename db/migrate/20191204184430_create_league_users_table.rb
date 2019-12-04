class CreateLeagueUsersTable < ActiveRecord::Migration[6.0]
  def change
    create_table :league_users do |t|
      t.references :user, foreign_key:true
      t.references :league, foreign_key:true
    end 
  end
end
