**Highspot Code Challenge Solution**

Instructions to run the app: 
* In your terminal, go the the project folder.
* Type the followings in your command line: ruby my_music_app.rb input.json changes.json output.json, in that exact order.
* The app should run and you should be able to see the changes written into the file output.json.


Below is a potential solution when input JSON file is very large
* We should build a server with three APIs to process get/users, get/playlists, and get/songs requests from our app
* Each API needs to process a batch size and an offset
* On our app, we repurpose the Translator class. This class will make the network calls with batch size in the request
so that it only retrieves the number of items that it can handle. Everytime it receives response from the server,
it will parse the data and save it to hard disk instead of RAM. Any modifications to the objects (songs, playlists, users) 
will be synced with the server using PATCH request. Our repurposed Translator class should also be able to handle network failures.