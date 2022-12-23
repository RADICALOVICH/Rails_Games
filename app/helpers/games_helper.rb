module GamesHelper

  def get_response(sql)
    HTTParty.post("https://api.igdb.com/v4/games", headers: {'Content-Type' => 'application/json',
      'Client-ID' => 'sc0xirv6am2awohhclusofg4xmwggv',
      'Authorization' => 'Bearer kfr137k16orpytawyims43hd6lfuai'},body: sql)
  end
  
  def add_to_database(json)
    json.each do |n|
      hash = n.to_h
      games = Game.new(name: get_name(hash), description: get_description(hash), avatar_url:
        get_url_avatar(hash), platforms: get_platforms(hash), genres: get_genres(hash), release_date:
        get_release_date(hash))
      games.save if games.valid?
    end
  end

  def get_name(hash)
    hash['name']
  end

  def get_description(hash)
    hash['summary']
  end

  def get_url_avatar(hash)
    "http:" +"#{hash['cover']['url'].gsub('t_thumb', 't_cover_big')}"
  end

  def get_platforms(hash)
    array_of_platforms_hash = hash['platforms']
    string = ''
    array_of_platforms_hash.each { |n| string += "#{n['name']}," }
    string.split(',')
  end

  def get_genres(hash)
    string = ''
    array_of_genres_hash = hash['genres']
    array_of_genres_hash.each { |n| string += "#{n['name']}," }
    string.split(',')
  end

  def get_release_date(hash)
    DateTime.strptime(hash['first_release_date'].to_s, '%s')
  end
end
