import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:notes/AddNoteWidget.dart';
import 'package:notes/AllNotes.dart';
import 'package:notes/DrawerWidget.dart';

import 'package:notes/Helpers/NoteFunctions.dart';
import 'package:notes/NoteWidget.dart';
import 'package:notes/HomePageStatful.dart';
import 'package:notes/model/dummy_data.dart';
import 'package:notes/model/Note.dart';
import 'package:notes/model/note.dart';

import 'AllLabelsWidget.dart';

class HomePage extends State<HomePageStateful> {
  int currentIndex = 0;
  late Widget CurrentWidget = AllNotes(
    notes: Notes,
  );

  String Title = "Notes";

  void Refresh() {
    print("refresh in the homepage screen");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
        drawer: DrawerWidget(),
        bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: Color.fromARGB(255, 221, 153, 187),
            currentIndex: currentIndex,
            onTap: (i) {
              currentIndex = i;
              if (currentIndex == 0) {
                CurrentWidget = AllNotes(
                  notes: Notes,
                );
                Title = "Notes";
              } else {
                CurrentWidget = AddNoteWidget();

                Title = "Add New Note";
              }

              setState(() {});
            },
            backgroundColor: Color.fromARGB(255, 31, 26, 56),
            items: [
              BottomNavigationBarItem(
                  label: '',
                  icon: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: SizedBox(
                        width: 23,
                        height: 23,
                        child: Image.asset(currentIndex == 0
                            ? "assets/sticky-notes_selected2.png"
                            : 'assets/sticky-notes.png')),
                  )),
              BottomNavigationBarItem(
                  label: '',
                  icon: SizedBox(
                      width: 23,
                      height: 23,
                      child: Image.asset(currentIndex == 1
                          ? "assets/add_selected2.png"
                          : 'assets/add.png'))),
              // BottomNavigationBarItem(
              //     label: '',
              //     icon: Container(
              //         width: 23,
              //         height: 23,
              //         child: Image.asset(currentIndex == 2
              //             ? "assets/price-tag_selected2.png"
              //             : 'assets/price-tag.png')))
            ]),
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 31, 26, 56),
          title: Text(Title),
          centerTitle: true,
        ),
        body: CurrentWidget);
  }
}
