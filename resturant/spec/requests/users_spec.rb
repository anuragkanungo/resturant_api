require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET /users" do
    it "works!" do
      get users_path
      expect(response).to have_http_status(401)
    end
  end
end
