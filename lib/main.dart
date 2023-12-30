import 'dart:math';

import 'package:flutter/material.dart';
import 'package:xoundbucket/screens/profile.dart';
import '/screens/login.dart' as sc;
import 'package:flutter/widgets.dart';
import './screens/demo.dart' as pf;

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(title: Text('Songs List')),
      body: sc.LoginPage(),
    ),
  ));
  // runApp(pf.MyApp());
}
