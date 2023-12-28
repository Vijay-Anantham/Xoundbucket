## Code snippet that was being used to test db fetching using a json db
 // FIXME: How useful is this function is upto question. Here for testing implementation will be taken down later
 Future<List<Songs>> getsongs() async {
   // TODO: Currently using JSON database for data fetching Update it to Mongodb atlas
   final database = JsonDatabase();
   database.insert({
     "id": 1,
     "songs": Songs("abc", "asf", "asg",
         "https://open.spotify.com/track/5iCY0TXNImK4hyKfcplQsg?si=b1a256437e964acd")
   });
   database.insert({
     "id": 2,
     "songs": Songs("acf", "ajy", "ahng",
         "https://open.spotify.com/track/6udC4b4jOSnHb9ItnXgKLR?si=7dc5912f96764a30")
   });
   database.insert({
     "id": 3,
     "songs": Songs("asf", "ahg", "asg",
         "https://open.spotify.com/track/2TIlqbIneP0ZY1O0EzYLlc?si=fd000fd369dc4732")
   });
   List<Map<String, dynamic>> deresult = database.selectAll();
   List<Songs> resultSongs = [Songs("name", "artist", "album", "link")];
   for (var entry in deresult) {
     resultSongs.add(entry['songs']);
   }
   TODO: How await and async works !?

   await Future.delayed(Duration(seconds: 1));
   return resultSongs;
 }