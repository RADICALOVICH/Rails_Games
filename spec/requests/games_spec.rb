require 'rails_helper'

RSpec.describe "Games", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/games/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /wishlist" do
    it "returns http success" do
      get "/games/wishlist"
      expect(response).to have_http_status(:success)
    end
  end

end
