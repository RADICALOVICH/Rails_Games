require 'rails_helper'

RSpec.describe 'user', type: :system do

  describe 'sign up' do
    scenario 'everything is correct' do
      visit new_user_path
  
      user = User.new(name: 'test', email: 'test@test.com', password: 'Testing12_!',
        password_confirmation: 'Testing12_!', email_confirmed: 'false')
  
      fill_in 'email_field', with: user.email
      fill_in 'name_field', with: user.name
      fill_in 'password_field', with: user.password
      fill_in 'password_confirmation_field', with: user.password_confirmation
  
      find('#btn_submit').click
  
      expect(page).to have_text('Confirm your email in the email')
    end

    scenario 'password confirmation is not correct' do
      visit new_user_path
  
      user = User.new(name: 'test', email: 'test@test.com', password: 'Testing12_!',
        password_confirmation: 'Testing12_!?', email_confirmed: 'true')
  
      fill_in 'email_field', with: user.email
      fill_in 'name_field', with: user.name
      fill_in 'password_field', with: user.password
      fill_in 'password_confirmation_field', with: user.password_confirmation
  
      find('#btn_submit').click
  
      expect(page).to have_text('Error in data entry or such user already exists')
    end

    scenario 'when such user already exists' do
      visit new_user_path
  
      user = User.create(name: 'test', email: 'test@test.com', password: 'Testing12_!',
        password_confirmation: 'Testing12_!', email_confirmed: 'true')
  
      fill_in 'email_field', with: user.email
      fill_in 'name_field', with: user.name
      fill_in 'password_field', with: user.password
      fill_in 'password_confirmation_field', with: user.password_confirmation
  
      find('#btn_submit').click
  
      expect(page).to have_text('Error in data entry or such user already exists')
    end
  end
  

  describe 'log in' do
    scenario 'everything is correct' do
      user = User.create(name: 'test', email: 'test@test.com', password: 'Testing12_!',
        password_confirmation: 'Testing12_!', email_confirmed: 'true')

      visit new_session_path

      fill_in 'email_field', with: user.email
      fill_in 'password_field', with: user.password

      find('#btn_submit').click

      expect(page).to have_text('Welcome back, test')
    end

    scenario 'when email is not confirmed' do
      user = User.create(name: 'test', email: 'test@test.com', password: 'Testing12_!',
        password_confirmation: 'Testing12_!', email_confirmed: 'false')

      visit new_session_path

      fill_in 'email_field', with: user.email
      fill_in 'password_field', with: user.password

      find('#btn_submit').click

      expect(page).to have_text('Please activate your account by following instructions in the account confirmation email')
    end

    scenario 'when such user is not exist' do
      user = User.new(name: 'test', email: 'test@test.com', password: 'Testing12_!',
        password_confirmation: 'Testing12_!', email_confirmed: 'false')

      visit new_session_path

      fill_in 'email_field', with: user.email
      fill_in 'password_field', with: user.password

      find('#btn_submit').click

      expect(page).to have_text('Error in mail and / or password')
    end

    scenario 'when error in field' do
      user = User.create(name: 'test', email: 'test@test.com', password: 'Testing12_!',
        password_confirmation: 'Testing12_!', email_confirmed: 'false')

      visit new_session_path

      fill_in 'email_field', with: user.email
      fill_in 'password_field', with: '12'

      find('#btn_submit').click

      expect(page).to have_text('Error in mail and / or password')
    end
  end

  describe 'edit profile' do
    scenario 'everything is correct' do
      user = User.create(name: 'test', email: 'test@test.com', password: 'Testing12_!',
        password_confirmation: 'Testing12_!', email_confirmed: 'true')
      visit new_session_path

      fill_in 'email_field', with: user.email
      fill_in 'password_field', with: user.password

      find('#btn_submit').click
      find('#navbarDarkDropdownMenuLink').click
      find('#edit_user_btn').click
      
      fill_in 'old_password_edit', with: user.password
      fill_in 'password_edit', with: 'Testing12_!?'
      fill_in 'password_confirmation_edit', with: 'Testing12_!?'
  
      find('#edit_btn').click
      expect(page).to have_text('Profile successfully updated')
    end

    scenario 'old password is not correct' do
      user = User.create(name: 'test', email: 'test@test.com', password: 'Testing12_!',
        password_confirmation: 'Testing12_!', email_confirmed: 'true')
      visit new_session_path

      fill_in 'email_field', with: user.email
      fill_in 'password_field', with: user.password

      find('#btn_submit').click
      find('#navbarDarkDropdownMenuLink').click
      find('#edit_user_btn').click
      
      fill_in 'old_password_edit', with: '12'
      fill_in 'password_edit', with: '1234'
      fill_in 'password_confirmation_edit', with: '1234'
  
      find('#edit_btn').click
      expect(page).to have_text('old password is invalid')
    end

    scenario 'password confirmation is not correct' do
      user = User.create(name: 'test', email: 'test@test.com', password: 'Testing12_!',
        password_confirmation: 'Testing12_!', email_confirmed: 'true')
      visit new_session_path

      fill_in 'email_field', with: user.email
      fill_in 'password_field', with: user.password

      find('#btn_submit').click
      find('#navbarDarkDropdownMenuLink').click
      find('#edit_user_btn').click
      
      fill_in 'old_password_edit', with: user.password
      fill_in 'password_edit', with: '1234'
      fill_in 'password_confirmation_edit', with: '12345'
  
      find('#edit_btn').click
      expect(page).to have_text("password confirmation doesn't match password")
    end
  end

  describe 'forgot password' do
    scenario 'send an email' do
      user = User.create(name: 'test', email: 'test@test.com', password: 'Testing12_!',
        password_confirmation: 'Testing12_!', email_confirmed: 'true')
      visit new_session_path
      find('#forgot_password_btn').click

      fill_in 'email_field', with: user.email
      find('#btn_submit').click
      expect(page).to have_text('Email with instructions was sent')
    end

    scenario 'user click on the email URL' do
      user = User.create(name: 'test', email: 'test@test.com', password: 'Testing12_!',
        password_confirmation: 'Testing12_!', email_confirmed: 'true', password_reset_token: 'token', password_reset_token_sent_at: Time.current())
      visit "/password_reset/edit?user%5Bemail%5D=test%40test.com&user%5Bpassword_reset_token%5D=token"
      expect(page).to have_text('Password update')
    end

    scenario 'user click on the email URL and fill form correctly' do
      user = User.create(name: 'test', email: 'test@test.com', password: 'Testing12_!',
        password_confirmation: 'Testing12_!', email_confirmed: 'true', password_reset_token: 'token', password_reset_token_sent_at: Time.current())
      visit "/password_reset/edit?user%5Bemail%5D=test%40test.com&user%5Bpassword_reset_token%5D=token"

      fill_in 'password_field', with: 'Testing12_!?'
      fill_in 'password_confirmation_field', with: 'Testing12_!?'

      find('#btn_submit_forgot').click
      expect(page).to have_text('Password updated successfully')
    end

    scenario 'user copy URL incorrectly' do
      user = User.create(name: 'test', email: 'test@test.com', password: '123',
        password_confirmation: '123', email_confirmed: 'true', password_reset_token: 'token', password_reset_token_sent_at: Time.current())
      visit "/password_reset/edit?user%5Bemail%5D=test%40test.com&user%5Bpassword_reset_token%5D=tokens"
      
      expect(page).to have_text('Failed to update password')
    end
  end

  describe 'log out' do
    scenario 'everything is correct' do
      user = User.create(name: 'test', email: 'test@test.com', password: 'Testing12_!',
        password_confirmation: 'Testing12_!', email_confirmed: 'true')
      visit new_session_path

      fill_in 'email_field', with: user.email
      fill_in 'password_field', with: user.password

      find('#btn_submit').click
      find('#navbarDarkDropdownMenuLink').click
      find('#log_out_btn').click
      
      expect(page).to have_text('See you later!')
    end
  end
end
