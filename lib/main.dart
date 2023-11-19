import 'dart:math';

import 'package:flutter/material.dart';
import '/screens/login.dart' as sc;
import 'package:flutter/widgets.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(title: Text('Songs List')),
      body: sc.LoginPage(),
    ),
  ));
}
