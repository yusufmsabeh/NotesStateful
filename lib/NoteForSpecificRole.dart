import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:lottie/lottie.dart';
import 'package:notes/DB/DBConaction.dart';
import 'package:notes/providers/DBprovider.dart';
import 'package:provider/provider.dart';

import 'NoteWidget.dart';

class NoteForSpecificRole extends StatelessWidget {
  Widget build(BuildContext context) {
    return Consumer<DBprovider>(builder: (context, provider, x) {
      return Scaffold(
        appBar: AppBar(
            backgroundColor: Color.fromARGB(255, 31, 26, 56),
            centerTitle: true,
            title: Text(provider.specificNotes.isEmpty
                ? "Note"
                : provider.specificNotes.first.role)),
        body: provider.notes.isEmpty
            ? Center(
                child: Container(
                    width: MediaQuery.of(context).size.width - 40,
                    height: MediaQuery.of(context).size.height - 40,
                    child: Lottie.asset('assets/animation/empty.json')))
            : ListView.builder(
                itemCount: provider.specificNotes.length,
                itemBuilder: (context, index) =>
                    NoteWidget(note: provider.specificNotes[index])),
      );
    });
  }
}
