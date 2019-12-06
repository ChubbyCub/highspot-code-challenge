require_relative "user"
require_relative "song"

class Playlist
  attr_reader :id, :user_id
  attr_accessor :song_ids

  def initialize(id:, user_id:)
    @id = id
    @user_id = user_id
    @song_ids = []
  end

  def to_json
    return {
             "id" => @id,
             "user_id" => @user_id,
             "song_ids" => @song_ids,
           }
  end
end
