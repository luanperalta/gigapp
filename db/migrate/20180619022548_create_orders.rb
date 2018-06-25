class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.datetime :dateTime
      t.string :invoice
      t.float :deliveryValue
      t.float :discount
      t.float :amount
      t.references :carrier, foreign_key: true

      t.timestamps
    end
  end
end
