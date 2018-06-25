class CreatePhones < ActiveRecord::Migration[5.2]
  def change
    create_table :phones do |t|
      t.string :areacode
      t.string :number
      t.string :reference
      t.references :supplier, foreign_key: true

      t.timestamps
    end
  end
end
