class AddWishlistToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :wishlist, :integer, array: true
  end
end
