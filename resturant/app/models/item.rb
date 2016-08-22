class Item < ApplicationRecord
  has_and_belongs_to_many :menus
  has_and_belongs_to_many :orders
  validates :name, :price, presence: true, on: :create
end
