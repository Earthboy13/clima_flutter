import 'dart:io';

import 'package:flutter/material.dart';

const kTempTextStyle = TextStyle(
  fontFamily: 'Spartan MB',
  fontSize: 100.0,
);

const kMessageTextStyle = TextStyle(
  fontFamily: 'Spartan MB',
  fontSize: 45.0,
);

const kButtonTextStyle = TextStyle(
  fontSize: 30.0,
  fontFamily: 'Spartan MB',
);

const kConditionTextStyle = TextStyle(
  fontSize: 100.0,
);

// ignore: unused_element
String path = _localPath;

String get _localPath {
  final directory = Directory('assets'); //await getApplicationDocumentsDirectory();
  //Directory.current.;
  //print(directory.path);
  return directory.path;
}
