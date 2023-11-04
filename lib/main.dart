import 'dart:math';

import 'package:flutter/material.dart';
import 'services/dbfetch.dart';
import 'db/Testdb.dart';
import 'package:xoundbucket/domain/domain.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(title: Text('Songs List')),
      body: SongList(),
    ),
  ));
}

Future<List<Songs>> getsongs() async {
  final database = JsonDatabase();
  database.insert({"id": 1, "songs": Songs("abc", "asf", "asg")});
  database.insert({"id": 2, "songs": Songs("acf", "ajy", "ahng")});
  database.insert({"id": 3, "songs": Songs("asf", "ahg", "asg")});
  List<Map<String, dynamic>> deresult = database.selectAll();
  List<Songs> resultSongs = [Songs("name", "artist", "album")];
  for (var entry in deresult) {
    resultSongs.add(entry['songs']);
  }
  await Future.delayed(Duration(seconds: 1));
  return resultSongs;
}

class SongList extends StatefulWidget {
  @override
  _SongListState createState() => _SongListState();
}

class _SongListState extends State<SongList> {
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
              return ListTile(
                title: Text(songs[index].name),
                subtitle: Text(songs[index].artist),
              );
            },
          );
        }
      },
    );
  }
}
