class ScreenshotsUrlsToGames < ActiveRecord::Migration[7.0]
  def change
    add_column :games, :screenshots_urls, :string, array: true
  end
end
