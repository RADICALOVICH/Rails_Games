require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    # тестируем, что модель проверяет наличие параметров и выводит соответствующее сообщение
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:password) }
    it { should have_secure_password }
    it { should validate_confirmation_of(:password) }
  end

  describe 'uniqueness of email' do
    subject { User.new(email: 'test@test.com', name: 'test', password: 'test') }
    it { should validate_uniqueness_of(:email) }
  end
  
  describe 'update user' do
    let!(:user_params) { {name: 'test', password: '123', password_confirmation: '123', email: 't@t.com' } }

    describe 'change password' do
      context 'with invalid old password' do
        it 'should return an error' do
          user = User.create!(user_params)
          expect(user.update(old_password: 'Invalid', password: '1234', password_confirmation: '1234')).to eq(false)
        end
      end
        context 'with valid old password' do
          it 'should update' do
            user = User.create!(user_params)
            expect(user.update(old_password: '123', password: '1234', password_confirmation: '1234')).to eq(true)
          end
        end
    end
    
    describe 'change email' do
      context 'with vaild old password' do
        it 'should update' do
          user = User.create!(user_params)
          expect(user.update(email: 'test@test.com', old_password: '123')).to eq(true)
        end
      end
      context 'with invaild old password' do
        it 'should return an error' do
          user = User.create!(user_params)
          expect(user.update(email: 'test@test.com', old_password: '1123')).to eq(false)
        end
      end
    end

    describe 'change name' do
      context 'with valid old password' do
        it 'should update' do
          user = User.create!(user_params)
          expect(user.update(name: 'name', old_password: '123')).to eq(true)
        end
      end
      context 'with invaild old password' do
        it 'should return an error' do
          user = User.create!(user_params)
          expect(user.update(email: 'test@test.com', old_password: '1123')).to eq(false)
        end
      end
    end
  end
end
