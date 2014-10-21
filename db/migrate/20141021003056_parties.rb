class Parties < ActiveRecord::Migration
  def change
  	create_table :parties do |t|
  		t.integer :table_no
  		t.integer :guest_no
  		t.boolean :paid
  		t.boolean :dufresnes

  		t.timestamps
  	end
  end
end