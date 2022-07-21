import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:notes/AllNotes.dart';
import 'package:notes/DB/DBConaction.dart';
import 'package:notes/model/Role.dart';
import 'package:notes/model/dummy_data.dart';
import 'package:notes/model/note.dart';

class DrawerWidget extends StatefulWidget {
  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  List<Role> roles = [];
  List<Note> notesForSpecificRole = [];
  @override
  void initState() {
    super.initState();
    readAllRoles();
  }

  void readByRole(String role) async {
    notesForSpecificRole = await connection.instance.readAllNoteByRole(role);

    setState(() {});
  }

  void readAllRoles() async {
    roles = await connection.instance.readAllRoles();
    setState(() {});
  }

  void Refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        backgroundColor: Color.fromARGB(255, 31, 26, 56),
        width: MediaQuery.of(context).size.width / 2,
        child: Container(
          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height / 20),
          child: Container(
            margin:
                EdgeInsets.only(top: MediaQuery.of(context).size.height / 20),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: Text(
                    "Labels".tr(),
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Color.fromARGB(255, 234, 215, 209)),
                  ),
                ),
                Expanded(
                  child: Container(
                    child: ListView.builder(
                        itemCount: roles.length,
                        itemBuilder: (context, index) => ListTile(
                              title: Container(
                                padding: EdgeInsets.only(bottom: 10),
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Colors.white, width: 1))),
                                child: TextButton(
                                  onPressed: () {
                                    readByRole(roles[index].RoleName);

                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Scaffold(
                                                appBar: AppBar(
                                                    backgroundColor:
                                                        Color.fromARGB(
                                                            255, 31, 26, 56),
                                                    centerTitle: true,
                                                    title: Text("Note")),
                                                body: AllNotes(
                                                    notes:
                                                        notesForSpecificRole))));
                                  },
                                  child: Text(
                                    roles[index].RoleName,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            )),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
