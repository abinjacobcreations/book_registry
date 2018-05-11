class ChangeColumnPriceOfBooks < ActiveRecord::Migration[5.1]
  def change
  	change_column :books, :price, :decimal,:precision=>30,:scale=>15
  end
end
