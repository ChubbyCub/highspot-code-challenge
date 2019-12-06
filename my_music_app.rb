require_relative "app_controller"
require_relative "translator"

controller = App_Controller.new(ARGV[0])
changes = Translator.parse_json_input(ARGV[1])

controller.add_song_to_playlist(playlist_id: changes["1"]["playlist_id"], song_id:changes["1"]["song_id"])
controller.add_new_playlist_for_user(user_id: changes["2"]["user_id"])
controller.remove_playlist(playlist_id: changes["3"]["playlist_id"])
controller.output_json(ARGV[2])

