import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:notes/NoteContent.dart';
import 'package:notes/model/note.dart';
import 'package:notes/providers/DBprovider.dart';
import 'package:provider/provider.dart';

class NoteWidget extends StatelessWidget {
  Note note;
  NoteWidget({required this.note});
  Widget build(BuildContext context) {
    return Consumer<DBprovider>(builder: (context, provider, x) {
      return InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => NoteContentWidget(
                        note: note,
                      )));
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 5,
          margin: EdgeInsets.all(15),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Color.fromARGB(200, 234, 215, 209),
              borderRadius: BorderRadius.circular(15)),
          child: Column(children: [
            Stack(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    note.title,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Color.fromARGB(255, 112, 108, 108)),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 31, 26, 56),
                        borderRadius: BorderRadius.circular(10)),
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                    child: Text(
                      note.role,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
            Divider(
              color: Colors.white,
              thickness: 1,
            ),
            Expanded(
              child: Text(overflow: TextOverflow.fade, note.text ?? ""),
            )
          ]),
        ),
      );
    });
  }
}
