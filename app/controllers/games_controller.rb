# frozen_string_literal: true

# Games
class GamesController < ApplicationController
  include GamesHelper

  before_action :user_is_admin?, only: :add_games

  @sql = 'fields name, genres.name, platforms.name, cover.url,
  first_release_date, summary, screenshots.url; where cover.url
  != null & genres != null & first_release_date != null
  & summary != null & screenshots.url != null;'

  def index
    @games = Game.all.page params[:page]
  end

  def show
    @game = Game.find(params[:id])
  end

  def add
    if current_user&.email != 'valerapolub@gmail.com'
      flash[:warning] = t('.warning')
      redirect_to root_path
    else
      sql = @sql
      response = get_response(sql)
      json = JSON.parse(response.body)
      add_to_database(json)
    end
  end

  def add_game
    @str = params[:game]
    list = current_user.wishlist + @str.split.map(&:to_i)
    current_user.update(wishlist: list)
  end

  def delete_game
    @str = params[:game]
    list = current_user.wishlist - @str.split.map(&:to_i)
    current_user.update(wishlist: list)
  end

  def search
    @games = Game.where('lower(name) LIKE ?',
                        "%#{Game.sanitize_sql_like(params[:name].downcase)}%")
  end
end
