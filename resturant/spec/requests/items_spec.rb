require 'rails_helper'

RSpec.describe "Items", type: :request do
  describe "GET /items" do
    it "works!" do
      get items_path
      expect(response).to have_http_status(401)
    end
  end
end
