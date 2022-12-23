require 'rails_helper'

RSpec.describe "Wishlists", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/wishlists/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /released" do
    it "returns http success" do
      get "/wishlists/released"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /unreleased" do
    it "returns http success" do
      get "/wishlists/unreleased"
      expect(response).to have_http_status(:success)
    end
  end

end
