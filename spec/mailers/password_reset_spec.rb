# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PasswordResetMailer, type: :mailer do
  context 'when we send registration letter' do
    let!(:user_params) { { name: 'test', password: '1234', password_confirmation: '1234', email: 'test@test.com'} }
    let!(:user) { User.create(user_params) }

    let(:mail) { PasswordResetMailer.reset_email(user) }

    it 'sents correct title' do
      expect(mail.subject).to eq('Password reset')
    end

    it 'sents letter to correct email' do
      expect(mail.to).to eq(['test@test.com'])
    end

    it 'sents letter from correct email' do
      expect(mail.from[0]).to eq 'list.of.games.app@gmail.com'
    end

    it 'renders the body' do
      expect(mail.body.encoded).not_to be_empty
    end
  end
end