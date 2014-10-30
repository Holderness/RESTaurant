class AddColumnToOrders < ActiveRecord::Migration
  def self.up
  	add_column :orders, :user_id, :integer
  end
end
