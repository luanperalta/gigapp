class CreateSuppliers < ActiveRecord::Migration[5.2]
  def change
    create_table :suppliers do |t|
      t.string :name
      t.string :description
      t.string :city
      t.string :address
      t.string :district
      t.integer :number

      t.timestamps
    end
  end
end
