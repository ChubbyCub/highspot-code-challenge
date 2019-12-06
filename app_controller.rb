require_relative "playlist"
require_relative "song"
require_relative "translator"
require_relative "user"

class App_Controller
  attr_reader :songs, :playlists, :users

  def initialize(file)
    data = Translator.parse_json_input(file)
    load_users(data)
    load_songs(data)
    load_playlists(data)
  end

  def add_song_to_playlist(playlist_id:, song_id:)
    @playlists[playlist_id].song_ids << song_id
  end

  def add_new_playlist_for_user(user_id:)
    new_playlist = Playlist.new(id: next_playlist_id(), user_id: user_id)
    new_playlist.song_ids << (@songs.keys[rand 0..@songs.length - 1])
    @playlists[new_playlist.id] = new_playlist
  end

  def remove_playlist(playlist_id:)
    @playlists.delete(playlist_id)
  end

  def output_json(file)
    return Translator.output_json_file(users: users, songs: songs, playlists: playlists, file: file)
  end

  private

  def load_users(data)
    @users = Hash.new
    data["users"].each { |user|
      @users[user["id"]] = User.new(id: user["id"], name: user["name"])
    }
  end

  def load_songs(data)
    @songs = Hash.new
    data["songs"].each { |song|
      @songs[song["id"]] = Song.new(id: song["id"], artist: song["artist"], title: song["title"])
    }
  end

  def load_playlists(data)
    @playlists = Hash.new
    data["playlists"].each { |playlist|
      new_playlist = Playlist.new(id: playlist["id"], user_id: playlist["user_id"])
      new_playlist.song_ids = playlist["song_ids"]
      @playlists[playlist["id"]] = new_playlist
    }
  end

  def next_playlist_id
    return (@playlists.max_by { |k, v| k }[0].to_i + 1).to_s
  end
end
