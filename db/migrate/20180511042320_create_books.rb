class CreateBooks < ActiveRecord::Migration[5.1]
  def change
    create_table :books do |t|
      t.string :book_name
      t.integer :category_id
      t.decimal :price, default: 0.0
      t.string :isbn
      t.string :author
      t.integer :publish_status, default: 0

      t.timestamps
    end
  end
end
