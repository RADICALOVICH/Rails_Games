require 'open-uri'

class Game < ApplicationRecord
  has_one_attached :avatar
  has_many_attached :screenshots
  before_save :grab_image
  paginates_per 10

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates_presence_of :description, :avatar_url, :platforms, :genres, :release_date, :screenshots_urls

  def grab_image
    downloaded_image = URI.parse(avatar_url).open
    avatar.attach(io: downloaded_image, filename: "#{name}.jpg")
    screenshots_urls.each_with_index do |n, i|
      downloaded_image = URI.parse(n).open
      screenshots.attach(io: downloaded_image, filename: "#{name}_screenshot_#{i}.jpg")
    end
  end

  scope :released, -> { where("release_date < ?", Time.current) }
  scope :unreleased, -> { where("release_date > ?", Time.current) }
end
