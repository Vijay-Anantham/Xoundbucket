import 'dart:math';

import 'package:flutter/material.dart';
import '../domain/domain.dart';
import '../db/Testdb.dart';
import '../widgets/songlistingtile.dart';
import 'package:flutter/widgets.dart';

Future<List<Songs>> getsongs() async {
  //TODO: Currently using JSON database for data fetching Update it to Mongodb atlas
  final database = JsonDatabase();
  database.insert({"id": 1, "songs": Songs("abc", "asf", "asg", "https://open.spotify.com/track/5iCY0TXNImK4hyKfcplQsg?si=b1a256437e964acd")});
  database.insert({"id": 2, "songs": Songs("acf", "ajy", "ahng", "https://open.spotify.com/track/6udC4b4jOSnHb9ItnXgKLR?si=7dc5912f96764a30")});
  database.insert({"id": 3, "songs": Songs("asf", "ahg", "asg", "https://open.spotify.com/track/2TIlqbIneP0ZY1O0EzYLlc?si=fd000fd369dc4732")});
  List<Map<String, dynamic>> deresult = database.selectAll();
  List<Songs> resultSongs = [Songs("name", "artist", "album", "link")];
  for (var entry in deresult) {
    resultSongs.add(entry['songs']);
  }
  //TODO: How await and async works !?

  await Future.delayed(Duration(seconds: 1));
  return resultSongs;
}

class SongList extends StatefulWidget {
  @override
  _SongListState createState() => _SongListState();
}

class _SongListState extends State<SongList> {
  //TODO: The UI is pretty dumb make a better UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Songs List'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      body: FutureBuilder<List<Songs>>(
      future: getsongs(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          final songs = snapshot.data;
          print("The Value of songs list $songs");
          if (songs == null) {
            return ListView.builder(
              itemCount: (songs != null) ? songs.length : 0,
              itemBuilder: (context, index) {
                return songListTile(
                  title: ("Song not exist"),
                  subtitle: ("Add songs to your library"),
                  spotifyLink: ("No Link"),
                );
              },
            );
          }
          return ListView.builder(
            itemCount: (songs != null) ? songs.length : 0,
            itemBuilder: (context, index) {
              return songListTile(
                title: songs[index].name,
                subtitle: songs[index].artist,
                spotifyLink: songs[index].link,
              );
            },
          );
        }
      },
      )
    );
  }
}
