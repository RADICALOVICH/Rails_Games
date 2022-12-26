require 'rails_helper'

RSpec.describe Game, type: :model do
  describe 'validations' do
    # тестируем, что модель проверяет наличие параметров и выводит соответствующее сообщение
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:platforms) }
    it { should validate_presence_of(:genres) }
    it { should validate_presence_of(:release_date) }
    it { should validate_presence_of(:avatar_url) }
    it { should validate_presence_of(:screenshots_urls) }
  end

  describe 'associations' do
    it { should have_one_attached(:avatar) }
    it { should have_many_attached(:screenshots) }
  end

  describe 'uniqueness' do
    subject { Game.new(name: 'test', description: 'test', platforms: ['test'],
      genres: ['test'], release_date: '2021-07-06 00:00:00.000', avatar_url: 'http://images.igdb.com/igdb/image/upload/t_cover_big/co4hk8.jpg', screenshots_urls: ['http://images.igdb.com/igdb/image/upload/t_cover_big/co4hk8.jpg'] ) }
    it { should validate_uniqueness_of(:name).case_insensitive }
  end

  describe 'platforms' do
    it { should allow_value(['test']).for(:platforms) }
    it { should_not allow_value('test').for(:platforms)}
  end

  describe 'genres' do
    it { should allow_value(['test']).for(:genres) }
    it { should_not allow_value('test').for(:genres) }
  end

  describe 'screenshots_urls' do
    it { should allow_value(['test']).for(:screenshots_urls) }
    it { should_not allow_value('test').for(:screenshots_urls) }
  end

  describe 'release date' do
    it { should allow_value('2021-07-06 00:00:00.000').for(:release_date) }
    it { should_not allow_value('test').for(:release_date)}
  end
end
