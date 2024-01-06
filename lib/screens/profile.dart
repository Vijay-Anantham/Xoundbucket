import 'dart:html';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
import 'package:xoundbucket/screens/songList.dart';

// Implements button styling
ButtonStyle buildButtonStyle() {
  return ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
    elevation: MaterialStateProperty.all<double>(8.0),
    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
      EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
    ),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    ),
  );
}

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Spotify Login Example',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String loginApiUrl =
      'http://localhost:3000/spotify/spotifyconnect'; // Replace with your actual login API endpoint

  // Function that redirect to the internal api call
  Future<void> launchLoginApi(String buttonName, BuildContext context) async {
    try {
      if (await canLaunchUrl(Uri.parse(loginApiUrl))) {
        await launchUrl(Uri.parse(loginApiUrl));
      } else {
        print("Url cannot be launched");
      }
      // FIXME: Right now we are using an await call but look for a way to make it more event driven
      await Future.delayed(Duration(seconds: 2));
      chekForward(context);
    } catch (error) {
      print('Error: $error');
    }
  }

  // Function to check if the application page can be transitioned into next window
  Future<void> chekForward(BuildContext context) async {
    final response =
        await http.get(Uri.parse("http://localhost:3000/spotify/state"));
    // FIXME: This is sometimes causing flow mismatch bad ux sometimes.
    print(response.body);
    if (response.body == "true") {
      Navigator.push(context, MaterialPageRoute(builder: (ctx) => SongList()));
    } else {
      print("Await has been crossed improve the logic");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Link platforms'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 200.0, // Set a fixed width for all buttons
              height: 60.0, // Set a fixed height for all buttons
              child: ElevatedButton(
                onPressed: () => launchLoginApi('Spotify', context),
                style: buildButtonStyle(),
                child: Text('Spotify'),
              ),
            ),
            SizedBox(height: 16.0), // Add spacing between buttons
            SizedBox(
              width: 200.0, // Set a fixed width for all buttons
              height: 60.0, // Set a fixed height for all buttons
              child: ElevatedButton(
                onPressed: () => launchLoginApi('Button 2', context),
                style: buildButtonStyle(),
                child: Text('Amazon Music'),
              ),
            ),
            SizedBox(height: 16.0), // Add spacing between buttons
            SizedBox(
              width: 200.0, // Set a fixed width for all buttons
              height: 60.0, // Set a fixed height for all buttons
              child: ElevatedButton(
                onPressed: () => launchLoginApi('Button 3', context),
                style: buildButtonStyle(),
                child: Text('Apple Music'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
