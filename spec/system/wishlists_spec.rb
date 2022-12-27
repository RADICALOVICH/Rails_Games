require 'rails_helper'

RSpec.describe 'wishlists', type: :system do
  describe 'check wishlist' do
    scenario 'all games' do
      user = User.create(name: 'testing', email: 'testing@test.com', password: 'Testing12_!',
        password_confirmation: 'Testing12_!', email_confirmed: 'true')
      visit new_session_path

      fill_in 'email_field', with: user.email
      fill_in 'password_field', with: user.password

      find('#btn_submit').click

      find('#wishlist_button').click

      expect(page).to have_button('All games')
      expect(page).to have_button('Released games')
      expect(page).to have_button('Unreleased games')
    end

    scenario 'add released game to wishlist' do
      user = User.create(name: 'testing', email: 'testing@test.com', password: 'Testing12_!',
        password_confirmation: 'Testing12_!', email_confirmed: 'true')
      visit new_session_path

      fill_in 'email_field', with: user.email
      fill_in 'password_field', with: user.password

      find('#btn_submit').click
      click_link('Ratchet & Clank: Rift Apart')
      click_button 'Add to wishlist'
      expect(page).to have_button('Delete from wishlist')
    end

    scenario 'add released game to wishlist and check it' do
      user = User.create(name: 'testing', email: 'testing@test.com', password: 'Testing12_!',
        password_confirmation: 'Testing12_!', email_confirmed: 'true')
      visit new_session_path

      fill_in 'email_field', with: user.email
      fill_in 'password_field', with: user.password

      find('#btn_submit').click
      click_link('Ratchet & Clank: Rift Apart')
      click_button 'Add to wishlist'
      find('#wishlist_button').click
      expect(page).to have_text('Ratchet & Clank: Rift Apart')
    end

    scenario 'delete game from wishlist' do
      user = User.create(name: 'testing', email: 'testing@test.com', password: 'Testing12_!',
        password_confirmation: 'Testing12_!', email_confirmed: 'true')
      visit new_session_path

      fill_in 'email_field', with: user.email
      fill_in 'password_field', with: user.password

      find('#btn_submit').click

      click_link('Ratchet & Clank: Rift Apart')
      click_button 'Add to wishlist'
      find('#wishlist_button').click
      sleep(1)
      click_button 'Delete from wishlist'
      expect(page).not_to have_text('Ratchet & Clank: Rift Apart')
    end

    scenario 'add unreleased game to wishlist and check it unreleased section' do
      user = User.create(name: 'test', email: 'test@test.com', password: 'Testing12_!',
        password_confirmation: 'Testing12_!', email_confirmed: 'true')
      visit new_session_path

      fill_in 'email_field', with: user.email
      fill_in 'password_field', with: user.password

      find('#btn_submit').click
      click_link("Marvel's Spider-Man 2")
      click_button 'Add to wishlist'
      find('#wishlist_button').click
      click_button 'Unreleased games'
      expect(page).to have_text("Marvel's Spider-Man 2")
    end
  end
end