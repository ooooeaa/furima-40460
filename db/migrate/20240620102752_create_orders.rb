class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.integer :user_id
      t.integer :item_id
      t.string :status

      t.timestamps
    end
  end
end
