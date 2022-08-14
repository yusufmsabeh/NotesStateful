import 'dart:developer';

import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:notes/DB/DBConaction.dart';
import 'package:notes/HomePage.dart';

import 'package:notes/model/Role.dart';
import 'package:notes/model/dummy_data.dart';
import 'package:notes/model/note.dart';
import 'package:notes/Helpers/NoteFunctions.dart';
import 'package:notes/providers/DBprovider.dart';
import 'package:provider/provider.dart';

class AddNoteWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<DBprovider>(builder: (context, provider, x) {
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
                      "TextFieldTitle".tr(),
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
                          controller: provider.titleController,
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
                      "TextFieldText".tr(),
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
                          controller: provider.textController,
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
                      "TextFieldLabel".tr(),
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
                            value: provider.selectedItem,
                            iconSize: 30,
                            // Down Arrow Icon
                            icon: Icon(Icons.arrow_drop_down_outlined),

                            // Array list of items
                            items: [
                              ...provider.roles.map(
                                (e) {
                                  return DropdownMenuItem(
                                    child: Text(e.RoleName),
                                    value: e.RoleName,
                                  );
                                },
                              ),
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
                                                title: Text(
                                                    "pageNameAddLabel".tr()),
                                                content: SizedBox(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height /
                                                      20,
                                                  child: Column(children: [
                                                    Row(
                                                      children: [
                                                        Text(
                                                          "TextFieldLabel".tr(),
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 20,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    31,
                                                                    26,
                                                                    56),
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
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              controller: provider
                                                                  .roleController,
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
                                                        provider
                                                            .addNewRoleMethod();
                                                        Navigator.pop(context);
                                                      },
                                                      child: Container(
                                                          width:
                                                              double.infinity,
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height /
                                                              20,
                                                          decoration: BoxDecoration(
                                                              color:
                                                                  Colors.green,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5)),
                                                          child: Center(
                                                            child: Text(
                                                              "ButtonAdd".tr(),
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
                                      child: Text("ButtonAddLabel".tr())))
                            ],
                            // After selecting the desired option,it will
                            // change button value to selected value
                            onChanged: (value) {
                              provider.changeSeletedItem(value);
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
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(5)),
                child: ElevatedButton(
                  onPressed: () {
                    provider.insertNote();
                  },
                  child: Text(
                    "ButtonAdd".tr(),
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
    });
  }
}
