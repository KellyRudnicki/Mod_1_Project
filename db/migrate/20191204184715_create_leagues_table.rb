class CreateLeaguesTable < ActiveRecord::Migration[6.0]
  def change
    create_table :leagues do |t|
      t.string :league_name
    end 
  end
end
