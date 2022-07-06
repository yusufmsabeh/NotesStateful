import 'package:flutter/material.dart';

class Note {
  late String title;
  String? text;
  late String role;
  Note.fromJson(Map Notes) {
    this.title = Notes['title'];
    this.text = Notes['text'];
    this.role = Notes['role'];
  }
  Note(this.title, this.text, this.role) {
    if (this.title == "") this.title = "Unknown";
    if (this.role == '') this.role = "other";
  }
}
