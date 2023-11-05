import 'package:flutter/material.dart';

// The ui is achieved by wrapping the list tile in the conatainer
class songListTile extends StatelessWidget {
  final String title;
  final String subtitle;

  songListTile({
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
        },
      ),
    );
  }
}
