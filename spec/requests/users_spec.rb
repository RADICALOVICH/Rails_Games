require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe 'GET /new' do
    before { get new_user_path }
    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'renders new template' do
      expect(response).to render_template(:new)
    end

    it 'responds with html' do
      expect(response.content_type).to match(%r{text/html})
    end
  end
end
