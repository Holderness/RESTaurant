class Foods < ActiveRecord::Migration
  def change
  	create_table :foods do |t|
  		t.string :name
  		t.string :cuisine_type
  		t.integer :price
  		t.string :allergens

  		t.timestamps
  	end
  end
end


