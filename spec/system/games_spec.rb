require 'rails_helper'

RSpec.describe 'game', type: :system do
  describe 'everything' do
    unreleased_game = Game.create(id:377,                                                       
      name: "Marvel's Spider-Man 2",                                 
      description:                                                   
       "Marvel's Spider-Man 2 is the next game in the critically acclaimed Marvel's Spider-Man franchise. Developed by Insomniac Games in collaboration with PlayStation and Marvel Games.",
      avatar_url: "http://images.igdb.com/igdb/image/upload/t_cover_big/co5vrx.jpg",
      platforms: ["PlayStation 5"],
      genres: ["Hack and slash/Beat 'em up", "Adventure"],
      release_date: 'Sun, 31 Dec 2023 00:00:00.000000000 UTC +00:00',
      screenshots_urls:
       ["http://images.igdb.com/igdb/image/upload/t_1080p/scfeho.jpg"])

    released_game = Game.create(id: 378,                                                       
      name: "Ratchet & Clank: Rift Apart",                           
      description:                                                   
       "Go dimension-hopping with Ratchet and Clank as they take on an evil emperor from another reality. Jump between action-packed worlds and beyond at mind-blowing speeds, complete with dazzling visuals and an insane arsenal.",
      avatar_url: "http://images.igdb.com/igdb/image/upload/t_cover_big/co2str.jpg",
      platforms: ["PlayStation 5"],                                  
      genres: ["Shooter", "Platform", "Adventure"],                  
      release_date: 'Fri, 11 Jun 2021 00:00:00.000000000 UTC +00:00',   
      screenshots_urls:                                              
       ["http://images.igdb.com/igdb/image/upload/t_1080p/sc8bit.jpg"])

    scenario 'see this games' do
      visit root_path

      expect(page).to have_text("Marvel's Spider-Man 2")
      expect(page).to have_text("Ratchet & Clank: Rift Apart")
    end

    scenario 'search one game' do
      visit root_path

      fill_in 'name_field', with: "Marvel's Spider-Man 2"

      find('#btn_submit').click

      expect(page).to have_text("Marvel's Spider-Man 2")
      expect(page).not_to have_text('Ratchet & Clank: Rift Apart')
    end

    scenario 'show one game and user is not log in' do
      visit '/games/378'
      expect(page).to have_button('Add to wishlist', disabled: true)
    end

    scenario 'show one game and user is log in' do
      user = User.create(name: 'testing', email: 'testing@test.com', password: 'Testing12_!',
        password_confirmation: 'Testing12_!', email_confirmed: 'true')
      visit new_session_path

      fill_in 'email_field', with: user.email
      fill_in 'password_field', with: user.password

      find('#btn_submit').click
      
      click_link('Ratchet & Clank: Rift Apart')
      expect(page).to have_button('Add to wishlist', disabled: false)
    end

    scenario 'when user is not log in index' do
      visit root_path
      expect(page).to have_button('Add to wishlist', disabled: true)
    end

    scenario 'when user log in index' do
      user = User.create(name: 'testing', email: 'testing@test.com', password: 'Testing12_!',
        password_confirmation: 'Testing12_!', email_confirmed: 'true')
      visit new_session_path

      fill_in 'email_field', with: user.email
      fill_in 'password_field', with: user.password

      find('#btn_submit').click

      expect(page).to have_button('Add to wishlist', disabled: false)
    end

    scenario 'trying to check admin button with regular user' do
      user = User.create(name: 'testing', email: 'Testing12_!', password: '12',
        password_confirmation: 'Testing12_!', email_confirmed: 'true')
      visit new_session_path

      fill_in 'email_field', with: user.email
      fill_in 'password_field', with: user.password

      find('#btn_submit').click

      visit '/games/add'

      expect(page).to have_text('Only for admin!')
    end

    scenario 'trying to check admin button with admin' do
      user = User.create(name: 'testing', email: 'valerapolub@gmail.com', password: 'Testing12_!',
        password_confirmation: 'Testing12_!', email_confirmed: 'true')
      visit new_session_path

      fill_in 'email_field', with: user.email
      fill_in 'password_field', with: user.password

      find('#btn_submit').click

      find('#add_button').click
      expect(page).to have_text('Everything is ok')
    end
  end
end