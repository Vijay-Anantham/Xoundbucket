import 'dart:html';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
import 'package:xoundbucket/screens/songList.dart';

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
      'http://localhost:3000/'; // Replace with your actual login API endpoint

  Future<void> launchLoginApi(String buttonName, BuildContext context) async {
    try {
      await launchUrl(Uri.parse(loginApiUrl));
      chekForward(context);
    } catch (error) {
      print('Error: $error');
    }
  }

  Future<void> chekForward(BuildContext context) async {
    final response = await http.get(Uri.parse("http://localhost:3000/state"));
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
          children: <Widget>[
            ElevatedButton(
              onPressed: () => launchLoginApi('Spotify', context),
              child: Text('Spotify'),
            ),
            ElevatedButton(
              onPressed: () => launchLoginApi('Button 2', context),
              child: Text('Amazon music'),
            ),
            ElevatedButton(
              onPressed: () => launchLoginApi('Button 3', context),
              child: Text('Apply music'),
            ),
          ],
        ),
      ),
    );
  }
}
