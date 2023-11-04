import 'dart:math';

import 'package:flutter/material.dart';
import 'services/dbfetch.dart';

class Songs {
  late String name;
  late String artist;
  late String album;
}

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(title: Text('Songs List')),
      body: SongList(),
    ),
  ));
}

class SongList extends StatefulWidget {
  @override
  _SongListState createState() => _SongListState();
}

class _SongListState extends State<SongList> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Songs>>(
      future: getSongs(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          final songs = snapshot.data;
          print("The Value of songs list $songs");
          return ListView.builder(
            itemCount: songs.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(songs[index].title),
                subtitle: Text(books[index].author),
              );
            },
          );
        }
      },
    );
  }
}
