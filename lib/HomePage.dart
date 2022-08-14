import 'dart:developer';
import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:notes/AddNoteWidget.dart';
import 'package:notes/AllNotes.dart';
import 'package:notes/DrawerWidget.dart';

import 'package:notes/Helpers/NoteFunctions.dart';
import 'package:notes/NoteWidget.dart';

import 'package:notes/model/dummy_data.dart';
import 'package:notes/model/note.dart';
import 'package:notes/DB/DBConaction.dart';
import 'package:notes/providers/DBprovider.dart';
import 'package:provider/provider.dart';

class HomePageStateful extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Consumer<DBprovider>(builder: (context, provider, x) {
      return Scaffold(
          drawer: DrawerWidget(),
          bottomNavigationBar: BottomNavigationBar(
              selectedItemColor: Color.fromARGB(255, 221, 153, 187),
              currentIndex: provider.currentIndex,
              onTap: (i) {
                provider.changeCurrentIndex(i);
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
                          child: Image.asset(provider.currentIndex == 0
                              ? "assets/sticky-notes_selected2.png"
                              : 'assets/sticky-notes.png')),
                    )),
                BottomNavigationBarItem(
                    label: '',
                    icon: SizedBox(
                        width: 23,
                        height: 23,
                        child: Image.asset(provider.currentIndex == 1
                            ? "assets/add_selected2.png"
                            : 'assets/add.png'))),
              ]),
          appBar: AppBar(
            actions: [
              IconButton(
                icon: Icon(Icons.language),
                onPressed: () {
                  log(context.locale.toString());
                  context.locale.toString() == 'en'
                      ? context.setLocale(Locale('ar'))
                      : context.setLocale(Locale('en'));
                  provider.Changetitle();
                  log(context.locale.toString());
                },
              ),
            ],
            backgroundColor: Color.fromARGB(255, 31, 26, 56),
            title: Text("pageNameNotes".tr()),
            centerTitle: true,
          ),
          body: provider.currentWidget);
    });
  }
}
