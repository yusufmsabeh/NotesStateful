import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:notes/AllNotes.dart';
import 'package:notes/model/dummy_data.dart';

class DrawerWidget extends StatefulWidget {
  late List<String> roles;

  DrawerWidget() {
    this.roles = Roles.map((e) => e).toList();
  }

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
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
                    "LABELS",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Color.fromARGB(255, 234, 215, 209)),
                  ),
                ),
                Expanded(
                  child: Container(
                    child: ListView.builder(
                        itemCount: widget.roles.length,
                        itemBuilder: (context, index) => ListTile(
                              title: Container(
                                padding: EdgeInsets.only(bottom: 10),
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Colors.white, width: 1))),
                                child: TextButton(
                                  onPressed: () {
                                    print((widget.roles[index]));
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
                                                    notes: Notes.where(
                                                            (element) =>
                                                                element.role ==
                                                                widget.roles[
                                                                    index])
                                                        .toList()))));
                                  },
                                  child: Text(
                                    widget.roles[index],
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
