require 'rails_helper'

RSpec.describe Item, type: :model do
  describe "Associations" do
    it { should have_and_belong_to_many(:menus) }
    it { should have_and_belong_to_many(:orders) }
  end
  describe "Validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:price) }
  end
end
