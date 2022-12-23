class AddDefaultValueToWishlist < ActiveRecord::Migration[7.0]
  def change
    change_column :users, :wishlist, :integer, array: true, default: []
  end
end
