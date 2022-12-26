require 'rails_helper'

RSpec.describe "Games", type: :request do
  describe "GET /index" do
    before { get root_path }
    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'renders index template' do
      expect(response).to render_template(:index)
    end

    it 'responds with html' do
      expect(response.content_type).to match(%r{text/html})
    end
  end

  describe "GET /add" do
    context 'when user is not log in' do
      before { get games_add_path }
      it 'returns http success' do
        expect(response).to have_http_status(302)
      end

      it 'renders index template' do
        expect(response).to redirect_to(root_path)
      end

      it 'responds with html' do
        expect(response.content_type).to match(%r{text/html})
      end
    end
  end
end
