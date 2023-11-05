import 'dart:math';

import 'package:flutter/material.dart';
import 'package:xoundbucket/widgets/songlistingtile.dart';
import 'db/Testdb.dart';
import 'package:xoundbucket/domain/domain.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(title: Text('Songs List')),
      body: SongList(),
    ),
  ));
}

Future<List<Songs>> getsongs() async {
  //TODO: Currently using JSON database for data fetching Update it to Mongodb atlas
  final database = JsonDatabase();
  database.insert({"id": 1, "songs": Songs("abc", "asf", "asg")});
  database.insert({"id": 2, "songs": Songs("acf", "ajy", "ahng")});
  database.insert({"id": 3, "songs": Songs("asf", "ahg", "asg")});
  List<Map<String, dynamic>> deresult = database.selectAll();
  List<Songs> resultSongs = [Songs("name", "artist", "album")];
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
    return FutureBuilder<List<Songs>>(
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
                return ListTile(
                  title: Text("Song not exist"),
                  subtitle: Text("Add songs to your library"),
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
              );
            },
          );
        }
      },
    );
  }
}
