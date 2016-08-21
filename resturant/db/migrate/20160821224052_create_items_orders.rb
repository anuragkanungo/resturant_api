class CreateItemsOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :items_orders do |t|
      t.belongs_to :item, index: true
      t.belongs_to :order, index: true
    end
  end
end
