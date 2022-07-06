import 'dart:developer';

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:notes/HomePage.dart';
import 'package:notes/HomePageStatful.dart';
import 'package:notes/model/dummy_data.dart';
import 'package:notes/model/note.dart';
import 'package:notes/Helpers/NoteFunctions.dart';

class AddNoteWidget extends StatefulWidget {
  AddNoteWidget() {}

  @override
  State<AddNoteWidget> createState() => _AddNoteWidgetState();
}

class _AddNoteWidgetState extends State<AddNoteWidget> {
  final titleController = TextEditingController();

  final textController = TextEditingController();
  final roleController = TextEditingController();

  String? selectedItem;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(top: 40, bottom: 10, left: 10, right: 10),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: Row(
                children: [
                  Text(
                    "Title",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Color.fromARGB(255, 31, 26, 56),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: MediaQuery.of(context).size.height / 20,
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 234, 215, 209),
                          borderRadius: BorderRadius.circular(10)),
                      child: TextField(
                        controller: titleController,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(border: InputBorder.none),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: Row(
                children: [
                  Text(
                    "Text",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Color.fromARGB(255, 31, 26, 56),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      height: MediaQuery.of(context).size.height / 2,
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 234, 215, 209),
                          borderRadius: BorderRadius.circular(10)),
                      child: TextField(
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        controller: textController,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(border: InputBorder.none),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: Row(
                children: [
                  Text(
                    "Label",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Color.fromARGB(255, 31, 26, 56),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: MediaQuery.of(context).size.height / 20,
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 234, 215, 209),
                          borderRadius: BorderRadius.circular(10)),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<dynamic>(
                          iconEnabledColor: Color.fromARGB(255, 31, 26, 56),

                          // Initial Value
                          value: selectedItem,
                          iconSize: 30,
                          // Down Arrow Icon
                          icon: const Icon(Icons.arrow_drop_down_outlined),

                          // Array list of items
                          items: [
                            ...Roles.map((String items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Text(items),
                              );
                            }).toList(),
                            DropdownMenuItem(
                                child: TextButton(
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              title: Text("Add New Label"),
                                              content: SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    20,
                                                child: Column(children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "Label",
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 20,
                                                          color: Color.fromARGB(
                                                              255, 31, 26, 56),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Container(
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height /
                                                              20,
                                                          margin: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      10),
                                                          decoration: BoxDecoration(
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      234,
                                                                      215,
                                                                      209),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10)),
                                                          child: TextField(
                                                            textAlign: TextAlign
                                                                .center,
                                                            controller:
                                                                roleController,
                                                            decoration: InputDecoration(
                                                                contentPadding:
                                                                    EdgeInsets.only(
                                                                        bottom: MediaQuery.of(context).size.height /
                                                                            20 /
                                                                            2),
                                                                border:
                                                                    InputBorder
                                                                        .none),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ]),
                                              ),
                                              actions: [
                                                TextButton(
                                                    onPressed: () {
                                                      Roles.add(
                                                          roleController.text);

                                                      roleController.text = '';
                                                      selectedItem = Roles.last;
                                                      Navigator.of(context)
                                                          .pop();
                                                      setState(() {});
                                                    },
                                                    child: Container(
                                                        width: double.infinity,
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height /
                                                            20,
                                                        decoration: BoxDecoration(
                                                            color: Colors.green,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5)),
                                                        child: Center(
                                                          child: Text(
                                                            "Add",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        )))
                                              ],
                                            );
                                          });
                                    },
                                    child: Text("+ Add New Label")))
                          ],
                          // After selecting the desired option,it will
                          // change button value to selected value
                          onChanged: (newValue) {
                            setState(() {
                              selectedItem = newValue;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 20,
              decoration: BoxDecoration(
                  color: Colors.green, borderRadius: BorderRadius.circular(5)),
              child: ElevatedButton(
                onPressed: () => NoteMethods.AddNote(titleController.text,
                    textController.text, selectedItem ?? ''),
                child: Text(
                  "ADD",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(primary: Colors.green),
              ),
            )
          ],
        ),
      ),
    );
  }
}
