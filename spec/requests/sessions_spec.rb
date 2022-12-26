require 'rails_helper'

RSpec.describe "Sessions", type: :request do
  describe 'GET /new' do
    before { get new_session_path } # перед каждым тестом делать запрос

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

  describe 'DELETE /destroy' do
    context 'when user is not log in' do
      before { delete session_path } # перед каждым тестом делать запрос

      it 'returns http success' do
        expect(response).to have_http_status(302)
      end

      it 'renders new template' do
        expect(response).to redirect_to(root_path)
      end

      it 'responds with html' do
        expect(response.content_type).to match(%r{text/html})
      end
    end
  end
end
