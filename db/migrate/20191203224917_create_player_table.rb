class CreatePlayerTable < ActiveRecord::Migration[6.0]
  def change
    create_table :players do | t |
      t.string :name 
      t.string :position
      t.integer :points
      t.integer :goals
    end 
  end
end
