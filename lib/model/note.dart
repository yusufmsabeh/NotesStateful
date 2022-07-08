import 'package:flutter/material.dart';
import 'package:notes/model/dummy_data.dart';

class Note {
  late int id;
  late String title;
  String? text;
  late String role;
  Note.fromJson(Map Notes) {
    this.id = idDummy + 1;
    this.title = Notes['title'];
    this.text = Notes['text'];
    this.role = Notes['role'];
  }

  Note.db(this.id, this.title, this.role, this.text);

  Map<String, dynamic> toJson() {
    return {
      'id': this.id,
      'title': this.title,
      'role': this.role,
      'text': this.text
    };
  }

  Note copy({required id}) {
    return Note.db(id, this.title, this.text ?? '', this.role);
  }

  Note(this.title, this.text, this.role) {
    this.id = idDummy + 1;

    if (this.title == "") this.title = "Unknown";
    if (this.role == '') this.role = "other";
  }
}
