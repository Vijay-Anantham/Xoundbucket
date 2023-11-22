import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

// The ui is achieved by wrapping the list tile in the conatainer
class songListTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final String spotifyLink;

  songListTile({
    required this.title,
    required this.subtitle,
    required this.spotifyLink,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Container(
      decoration: BoxDecoration(
        color: Colors.blue,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            offset: Offset(2, 2),
            blurRadius: 5,
            spreadRadius: 1,
          ),
        ],
      ),

      child: ListTile(
        title: Text(
          title,
          style: TextStyle(color: Colors.white),
        ),
        leading: Icon(Icons.star, color: Colors.yellow),
        subtitle: Text(
          subtitle,
          style: TextStyle(color: Colors.white),
        ),
        trailing: Icon(Icons.arrow_forward, color: Colors.white),
        onTap: () {
          // Handle tap
          _launchSpotifyLink(context);
        },
      ),
    ));
  }

  _launchSpotifyLink(BuildContext context) async {
    if (await canLaunchUrl(Uri.parse(spotifyLink))) {
      await launchUrl(Uri.parse(spotifyLink));
    } else {
      // Handle the case where the user cannot launch the link (e.g., no browser installed)
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Could not launch Spotify link.'),
        ),
      );
    }
  }
}
