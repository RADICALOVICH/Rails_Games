class CreateGames < ActiveRecord::Migration[7.0]
  def change
    create_table :games do |t|
      t.string :name
      t.text :description
      t.string :avatar_url
      t.string :platforms, array: true
      t.string :genres, array: true
      t.timestamp :release_date

      t.timestamps
    end
  end
end
