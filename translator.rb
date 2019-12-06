require "httparty"
require "json"

class Translator
  def self.parse_json_input(file)
    return JSON.parse(File.read(file))
  end

  def self.output_json_file(users:, songs:, playlists:, file:)
    users_jsons = users.values.map { |user| user.to_json }
    playlists_jsons = playlists.values.map { |playlist| playlist.to_json }
    songs_jsons = songs.values.map { |song| song.to_json }

    File.open(file, "w") { |file| file.truncate(0) }

    File.open(file, "w") do |file|
      file.write(JSON.pretty_generate({ "users:" => users_jsons,
                                        "playlists:" => playlists_jsons,
                                        "songs" => songs_jsons }))
    end
  end
end
