import 'dart:async';

import 'package:flutter/material.dart';
import 'package:notes/model/Role.dart';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../model/note.dart';

class connection {
  static final connection instance = connection._init();
  static Database? _database;

  connection._init();
  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('NoteAppDB.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path,
        version: 1, onCreate: _createDB, onConfigure: _onConfigure);
  }

  static Future _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final titleType = 'TEXT';
    final textType = 'TEXT';
    final roleType = 'TEXT';

    final roleNameType = 'TEXT PRIMARY KEY ';
    await db.execute(
        'CREATE TABLE $tabelRole (${RoleFields.roleName} $roleNameType)');

    await db.execute(
        'CREATE TABLE $tabelNotes( ${NoteFields.id} $idType,${NoteFields.title} $titleType,${NoteFields.role} $roleType, ${NoteFields.text} $textType,FOREIGN KEY(${NoteFields.role}) REFERENCES   $tabelRole(${RoleFields.roleName}))');
    await db.insert(tabelRole, {RoleFields.roleName: 'other'});
  }

  Future<List<Role>> readAllRoles() async {
    final db = await instance.database;
    final maps = await db.query(
      tabelRole,
      columns: RoleFields.values,
    );

    List<Role> roles = [];

    maps.forEach((e) => roles.add(Role.fromJson(e)));

    return roles;
  }

  void InsertRole(Role role) async {
    final db = await instance.database;
    await db.insert(tabelRole, role.toJson());
  }

  Future<Note> readNote(int id) async {
    final db = await instance.database;
    final maps = await db.query(tabelNotes,
        columns: NoteFields.values,
        where: '${NoteFields.id}=?',
        whereArgs: [id]);
    if (maps.isNotEmpty) {
      return Note.fromJson(maps.first);
    } else {
      throw Exception("id $id not found");
    }
  }

  Future<List<Note>> readAllNoteByRole(String role) async {
    final db = await instance.database;
    final maps = await db.query(tabelNotes,
        columns: NoteFields.values,
        where: '${NoteFields.role}=?',
        whereArgs: [role]);

    List<Note> notes = [];

    maps.forEach((e) => notes.add(Note.fromJson(e)));

    return notes;
  }

  Future<List<Note>> readallNotes() async {
    final db = await instance.database;
    final maps = await db.query(
      tabelNotes,
      columns: NoteFields.values,
    );

    List<Note> notes = [];

    maps.forEach((e) => notes.add(Note.fromJson(e)));

    return notes;
  }

  Future<Note> create(Note note) async {
    final db = await instance.database;
    final id = await db.insert(tabelNotes, note.toJson());

    return note.copy(id: id);
  }

  Future<int> update(Note note) async {
    final db = await instance.database;
    return db.update(tabelNotes, note.toJson(),
        where: '${NoteFields.id}=?', whereArgs: [note.id]);
  }

  Future<int> delete(int id) async {
    final db = await instance.database;
    return await db
        .delete(tabelNotes, where: '${NoteFields.id}=?', whereArgs: [id]);
  }

  Future close() async {
    final db = await instance.database;
    db.close;
  }
}
