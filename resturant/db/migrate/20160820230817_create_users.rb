class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.string :name
      t.string :address
      t.string :phone
      t.string :role

      t.timestamps
    end
  end
end
