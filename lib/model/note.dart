import 'package:flutter/material.dart';
import 'package:notes/model/dummy_data.dart';

final String tabelNotes = 'NoteTabell';

class NoteFields {
  static final List<String> values = [id, title, text, role];

  static final String id = '_id';
  static final String title = '_title';
  static final String text = '_textnote';
  static final String role = '_role';
}

class Note {
  final int? id;
  final String title;
  String? text;
  final String role;

  Note({this.id, required this.title, required this.text, required this.role});

  static Note fromJson(Map json) => Note(
      id: json[NoteFields.id] as int?,
      title: json[NoteFields.title] as String,
      text: json[NoteFields.text] as String,
      role: json[NoteFields.role] as String);

  Note.db(this.id, this.title, this.role, this.text);

  Map<String, dynamic> toJson() => {
        NoteFields.id: id,
        NoteFields.title: title,
        NoteFields.role: role,
        NoteFields.text: text
      };

  Note copy({int? id, String? title, String? text, String? role}) => Note(
      id: id ?? this.id,
      title: title ?? this.title,
      text: text ?? this.text,
      role: role ?? this.role);

  @override
  String toString() {
    // TODO: implement toString
    return role;
  }
}
