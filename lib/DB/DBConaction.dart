import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../model/note.dart';

class connection {
  static final connection instance = connection._init();
  static Database? _database;

  connection._init();
  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('notes.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute(
        'CREATE TABEL notes( id INTEGER PRIMARY KEY AUTOINCREMENT,title TEXT,role TEXT, textnote TEXT)');
  }

  Future<Note> readNote(int id) async {
    final db = await instance.database;
    final maps = await db.query('note',
        columns: ['id', 'title', 'role', 'text'],
        where: 'id=?',
        whereArgs: [id]);
    if (maps.isNotEmpty) {
      return Note.fromJson(maps.first);
    } else {
      throw Exception("id $id not found");
    }
  }

  Future<List<Note>> readallNotes(String role) async {
    final db = await instance.database;
    final maps = await db.query('note',
        columns: ['id', 'title', 'text', 'role'],
        where: 'role=?',
        whereArgs: [role]);

    List<Note> notes = [];
    maps.map((e) => notes.add(Note.fromJson(e)));
    return notes;
  }

  Future<List<Note>> readNotesByRole() async {
    final db = await instance.database;
    final maps = await db.query(
      'note',
      columns: ['id', 'title', 'text', 'role'],
    );

    List<Note> notes = [];
    maps.map((e) => notes.add(Note.fromJson(e)));
    return notes;
  }

  Future<Note> create(Note note) async {
    final db = await instance.database;
    final id = await db.insert('notes', note.toJson());
    return note.copy(id: id);
  }

  Future close() async {
    final db = await instance.database;
    db.close;
  }
}
