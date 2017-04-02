class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.string :name
      t.boolean :sold_out, default: false
      t.string :category
      t.boolean :under_sale, default: false
      t.integer :price
      t.integer :sale_price
      t.timestamps
    end
  end
end
