class GamesController < ApplicationController
  include GamesHelper

  before_action :user_is_admin?, only: :add_games

  def index
    @games = Game.all
  end

  def add
    if current_user&.email != 'valerapolub@gmail.com'
      flash[:warning] = 'Только для админа!'
      redirect_to root_path
    else
      sql = 'fields name, genres.name, platforms.name, cover.url, first_release_date, summary;
      where cover.url != null & genres != null & first_release_date != null & summary != null & platforms = 167;
      limit 100;'
      response = get_response(sql)
      json = JSON.parse(response.body)
      add_to_database(json)
    end
  end
end
