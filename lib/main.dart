import 'package:flutter/material.dart';
import 'package:notes/HomePage.dart';
import 'package:notes/HomePageStatful.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomePageStateful(),
  ));
}
