import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:notes/AppRouter.dart';
import 'package:notes/DB/DBConaction.dart';
import 'package:notes/model/dummy_data.dart';
import 'package:notes/providers/DBprovider.dart';
import 'package:provider/provider.dart';

import 'model/note.dart';

class EditWidget extends StatelessWidget {
  Note note;
  EditWidget({required this.note}) {
    Provider.of<DBprovider>(AppRouter.navKey.currentContext!)
        .changeTextEditingText(note);
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<DBprovider>(builder: (context, provider, x) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 31, 26, 56),
          title: Text("pageNameEditNote".tr()),
          centerTitle: true,
        ),
        body: Container(
          margin: EdgeInsets.only(top: 20),
          padding: EdgeInsets.symmetric(horizontal: 10),
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
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 31, 26, 56),
                              borderRadius: BorderRadius.circular(10)),
                          padding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 5),
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
                child: TextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  controller: provider.textControllerEdit,
                  style: TextStyle(fontSize: 19),
                  decoration: InputDecoration(border: InputBorder.none),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20, bottom: 20),
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 20,
              decoration: BoxDecoration(
                  color: Colors.green, borderRadius: BorderRadius.circular(5)),
              child: ElevatedButton(
                onPressed: () {
                  provider.updateNote(note);
                  Navigator.pop(context);
                },
                child: Text(
                  "ButtonEdit".tr(),
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(primary: Colors.green),
              ),
            )
          ]),
        ),
      );
    });
  }
}
