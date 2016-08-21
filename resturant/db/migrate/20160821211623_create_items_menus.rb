class CreateItemsMenus < ActiveRecord::Migration[5.0]
  def change
    create_table :items_menus, id: false do |t|
      t.belongs_to :item, index: true
      t.belongs_to :menu, index: true
    end
  end
end
