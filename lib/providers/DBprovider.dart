import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:notes/AllNotes.dart';
import 'package:notes/DB/DBConaction.dart';
import 'package:notes/model/Role.dart';
import 'package:notes/model/note.dart';

import '../AddNoteWidget.dart';

class DBprovider extends ChangeNotifier {
  int currentIndex = 0;
  Widget currentWidget = AllNotes();
  String Title = "pageNameNotes".tr();
  List<Note> notes = [];
  List<Note> specificNotes = [];
  List<Role> roles = [];

  final titleController = TextEditingController();
  final textController = TextEditingController();
  final roleController = TextEditingController();

  final textControllerEdit = TextEditingController();
  String? selectedItem;

  DBprovider() {
    readAllNotes();
    readAllRoles();
  }

  readAllRoles() async {
    roles = await connection.instance.readAllRoles();
    notifyListeners();
  }

  insertRole(Role role) async {
    await connection.instance.InsertRole(role);
    readAllRoles();
  }

  readNote(int id) async {
    return await connection.instance.readNote(id);
  }

  readAllNotesByRole(String role) async {
    specificNotes = await connection.instance.readAllNoteByRole(role);
    log(role);
    log(specificNotes.toString());
    notifyListeners();
  }

  readAllNotes() async {
    notes = await connection.instance.readallNotes();
    notifyListeners();
  }

  insertNote() async {
    Note note = Note(
        title: titleController.text == '' ? 'Unknown' : titleController.text,
        text: textController.text,
        role: selectedItem ?? 'other');

    titleController.text = '';
    textController.text = '';
    await connection.instance.create(note);
    readAllNotes();
  }

  updateNote(Note note) async {
    note.text = textControllerEdit.text;
    await connection.instance.update(note);
    readAllNotes();
  }

  deleteNote(int id) async {
    await connection.instance.delete(id);
    readAllNotes();
  }

  changeSeletedItem(String value) {
    selectedItem = value;
    notifyListeners();
  }

  addNewRoleMethod() {
    bool isFound = false;
    roles.forEach((element) {
      if (element.RoleName == roleController.text) isFound = true;
    });

    if (!isFound) {
      insertRole(Role(RoleName: roleController.text));
      selectedItem = roles.last.RoleName;
    }
    roleController.text = '';
  }

  changeTextEditingText(Note note) {
    textControllerEdit.text = note.text ?? '';
    notifyListeners();
  }

  void Changetitle() {
    currentIndex == 0
        ? Title = "pageNameNotes".tr()
        : Title = "pageNameAddNote".tr();
    notifyListeners();
  }

  changeCurrentIndex(int value) {
    currentIndex = value;
    if (currentIndex == 0) {
      currentWidget = AllNotes();
      Title = "pageNameNotes".tr();
    } else {
      currentWidget = AddNoteWidget();

      Title = "pageNameAddNote".tr();
    }
    notifyListeners();
  }
}
