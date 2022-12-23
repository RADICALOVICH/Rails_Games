require 'open-uri'

class Game < ApplicationRecord
  has_one_attached :avatar
  before_save :grab_image

  validates :name, uniqueness: { case_sensitive: false }
  validates_presence_of :name, :description, :avatar_url, :platforms, :genres, :release_date

  def grab_image
    downloaded_image = URI.parse(avatar_url).open
    avatar.attach(io: downloaded_image, filename: "#{name}.jpg")
  end
end
