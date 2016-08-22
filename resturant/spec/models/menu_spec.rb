require 'rails_helper'

RSpec.describe Menu, type: :model do
  describe "Associations" do
    it { should have_and_belong_to_many(:items) }
  end
end
