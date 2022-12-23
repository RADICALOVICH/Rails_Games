class WishlistsController < ApplicationController
  before_action :authentication, only: %i[index released unreleased]

  def index
    @games = Game.where(id: current_user.wishlist)
  end

  def released
    @games = Game.released.where(id: current_user.wishlist)
  end

  def unreleased
    @games = Game.unreleased.where(id: current_user.wishlist)
  end

  def delete_game
    @str = params[:game]
    list = current_user.wishlist - @str.split.map(&:to_i)
    current_user.update(wishlist: list)
  end
end
