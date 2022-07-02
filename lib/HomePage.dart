import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:notes/AddNoteWidget.dart';
import 'package:notes/DrawerWidget.dart';
import 'package:notes/Helpers/NoteFunctions.dart';
import 'package:notes/NoteWidget.dart';
import 'package:notes/HomePageStatful.dart';
import 'package:notes/model/dummy_data.dart';
import 'package:notes/model/Note.dart';
import 'package:notes/model/note.dart';

class HomePage extends State<HomePageStateful> {
  List? HomePageNote;
  List? HomePageRoles;
  final titleController = TextEditingController();
  final textController = TextEditingController();
  final roleController = TextEditingController();

  HomePage() {
    Refresh();
  }

  void Refresh() {
    HomePageNote = Notes;
    if (Notes.length != 0)
      HomePageRoles = Notes.map((e) => e.role).toList();
    else
      HomePageRoles?.add("other");
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
        drawer: DrawerWidget(),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color.fromARGB(255, 31, 26, 56),
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    backgroundColor: Color.fromARGB(255, 31, 26, 56),
                    actions: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 4,
                            height: MediaQuery.of(context).size.height / 20,
                            margin: EdgeInsets.all(
                                MediaQuery.of(context).size.height / 40),
                            decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(10)),
                            child: FlatButton(
                              onPressed: () {
                                NoteMethods.AddNote(titleController.text,
                                    textController.text, roleController.text);
                                titleController.text = "";
                                textController.text = "";
                                roleController.text = "";
                                setState(() {
                                  Refresh();
                                });
                              },
                              child: Text(
                                "Add",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(
                                MediaQuery.of(context).size.height / 40),
                            width: MediaQuery.of(context).size.width / 4,
                            height: MediaQuery.of(context).size.height / 20,
                            decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(10)),
                            child: FlatButton(
                              onPressed: null,
                              child: Text(
                                "Cancel",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                        side: BorderSide(
                            color: Color.fromARGB(255, 234, 215, 209))),
                    title: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Add Note",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    content: Expanded(
                      child: Container(
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                  bottom:
                                      MediaQuery.of(context).size.height / 25),
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 234, 215, 209),
                                  borderRadius: BorderRadius.circular(10)),
                              child: TextField(
                                controller: titleController,
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                    hintText: "Title",
                                    border: InputBorder.none),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  bottom:
                                      MediaQuery.of(context).size.height / 25),
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 234, 215, 209),
                                  borderRadius: BorderRadius.circular(10)),
                              child: TextField(
                                controller: roleController,
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                    hintText: "Role", border: InputBorder.none),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(
                                    bottom: MediaQuery.of(context).size.height /
                                        25),
                                decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 234, 215, 209),
                                    borderRadius: BorderRadius.circular(10)),
                                child: TextField(
                                  controller: textController,
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                      hintText: "Text",
                                      border: InputBorder.none),
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 234, 215, 209),
                                  borderRadius: BorderRadius.circular(10)),
                              width: double.infinity,
                              child: DropdownButton<String>(
                                value: HomePageRoles?[0],
                                items: HomePageRoles?.map((item) =>
                                        DropdownMenuItem<String>(
                                            value: item,
                                            child: Text(item ?? "others")))
                                    .toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    HomePageRoles?[0] = newValue!;
                                  });
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                });

            // showDialog(context: context, builder: (context) => AddNoteWidget());
          },
          child: const SizedBox(
            width: 50,
            height: 50,
            child: CircleAvatar(
                backgroundColor: Color.fromARGB(255, 31, 26, 56),
                child: Text(
                  "+",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Colors.white),
                )),
          ),
        ),
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 31, 26, 56),
          title: Text("Notes"),
          centerTitle: true,
        ),
        body: ListView.builder(
            itemCount: Notes.length,
            itemBuilder: (context, index) => NoteWidget(Notes[index])));
  }
}
