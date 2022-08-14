import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:notes/DB/DBConaction.dart';
import 'package:notes/EditWidget.dart';
import 'package:notes/model/dummy_data.dart';

import 'package:notes/model/note.dart';
import 'package:notes/providers/DBprovider.dart';
import 'package:provider/provider.dart';

class NoteContentWidget extends StatelessWidget {
  Note note;
  NoteContentWidget({required this.note});

  @override
  Widget build(BuildContext context) {
    return Consumer<DBprovider>(builder: (context, provider, x) {
      return Scaffold(
          appBar: AppBar(
              backgroundColor: Color.fromARGB(255, 31, 26, 56),
              centerTitle: true,
              title: Text("pageNameNote".tr())),
          body: Center(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              padding: EdgeInsets.all(8),
              child: ListView(children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Stack(
                    children: [
                      Align(
                        alignment: context.locale.toString() == 'en'
                            ? Alignment.topLeft
                            : Alignment.topRight,
                        child: Text(
                          note.title,
                          style: TextStyle(
                              color: Color.fromARGB(255, 31, 26, 56),
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () {
                                provider.deleteNote(note.id ?? 0);

                                Navigator.pop(context);
                              },
                              child: Container(
                                margin: EdgeInsets.only(right: 10),
                                child: Image.asset(
                                  "assets/delete.png",
                                  width: 23,
                                  height: 23,
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return EditWidget(
                                    note: note,
                                  );
                                }));
                              },
                              child: Container(
                                margin: EdgeInsets.only(right: 10),
                                child: Image.asset(
                                  "assets/edit.png",
                                  width: 23,
                                  height: 23,
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 31, 26, 56),
                                  borderRadius: BorderRadius.circular(10)),
                              padding: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 5),
                              child: Text(
                                note.role,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color.fromARGB(200, 234, 215, 209),
                        borderRadius: BorderRadius.circular(15)),
                    margin: EdgeInsets.only(top: 10),
                    padding: EdgeInsets.all(10),
                    child: Text(
                      note.text ?? '',
                      style: TextStyle(fontSize: 19),
                    ),
                  ),
                )
              ]),
            ),
          ));
    });
  }
}
