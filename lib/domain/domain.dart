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
