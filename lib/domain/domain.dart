class Songs {
  late String name;
  late String artist;
  late String album;
  late String link;

  Songs(this.name, this.artist, this.album, this.link);
}

class user {
  late String name;
  late List<Songs> recentlistens;
}

class Playlist {
  final String name;
  final String url;

  Playlist({required this.name, required this.url});

  factory Playlist.fromJson(Map<String, dynamic> json) {
    return Playlist(
      name: json['name'] ?? '',
      url: json['url'] ?? '',
    );
  }
}
