require 'rails_helper'

RSpec.describe "Orders", type: :request do
  describe "GET /orders" do
    it "works!" do
      get orders_path
      expect(response).to have_http_status(401)
    end
  end
end
