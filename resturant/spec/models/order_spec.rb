require 'rails_helper'

RSpec.describe Order, type: :model do
  describe "Associations" do
    it { should have_and_belong_to_many(:items) }
    it { should belong_to(:user) }
  end
end
