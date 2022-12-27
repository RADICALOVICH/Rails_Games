# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserMailer, type: :mailer do
  context 'when we send registration letter' do
    let!(:user_params) {{ name: 'test', password: 'Testing12_!', password_confirmation: 'Testing12_!', email: 'test@test.com'}}
    let!(:user) { User.create(user_params) }

    let(:mail) { UserMailer.registration_confirmation(user) }

    it 'sents correct title' do
      expect(mail.subject).to eq('Registration Confirmation')
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