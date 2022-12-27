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
    subject { User.new(email: 'test@test.com', name: 'Test1!_gh', password: 'test') }
    it { should validate_uniqueness_of(:email) }
  end

  describe 'check email validation' do
    it { should allow_value('test@test.com').for(:email) }
    it { should_not allow_value('test').for(:email) }
    it { should_not allow_value('test@').for(:email) }
    it { should_not allow_value('test@.').for(:email) }
    it { should_not allow_value('test@.com').for(:email) }
    it { should_not allow_value('test@gmail.').for(:email) }
    it { should_not allow_value('test.com').for(:email) }
    it { should_not allow_value('test@.com').for(:email) }
  end

  describe 'check password validation' do
    it { should allow_value('Testing12_!').for(:password) }
    it { should_not allow_value('Testing').for(:password) }
    it { should_not allow_value('Testing1').for(:password) }
    it { should_not allow_value('Testing!').for(:password) }
    it { should_not allow_value('testing!_').for(:password) }
    it { should_not allow_value('Testing1').for(:password) }
    it { should_not allow_value('T!_2').for(:password) }
    it { should_not allow_value('Test2_?').for(:password) }
  end
  
  describe 'update user' do
    let!(:user_params) { {name: 'test', password: 'Testing12_!', password_confirmation: 'Testing12_!', email: 't@t.com' } }

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
            expect(user.update(old_password: 'Testing12_!', password: 'Testing12_!?', password_confirmation: 'Testing12_!?')).to eq(true)
          end
        end
    end
    
    describe 'change email' do
      context 'with vaild old password' do
        it 'should update' do
          user = User.create!(user_params)
          expect(user.update(email: 'test@test.com', old_password: 'Testing12_!')).to eq(true)
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
          expect(user.update(name: 'name', old_password: 'Testing12_!')).to eq(true)
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
