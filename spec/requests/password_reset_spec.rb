require 'rails_helper'

RSpec.describe "PasswordResets", type: :request do
  describe 'GET /new' do
    context 'when user is not log in' do
      before { get new_password_reset_path } # перед каждым тестом делать запрос
  
      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end
  
      it 'renders template' do
        expect(response).to render_template(:new)
      end
  
      it 'responds with html' do
        expect(response.content_type).to match(%r{text/html})
      end
    end
  end
end