import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:lottie/lottie.dart';
import 'package:notes/DB/DBConaction.dart';
import 'package:notes/providers/DBprovider.dart';
import 'package:provider/provider.dart';

import 'NoteWidget.dart';
import 'model/note.dart';
import 'model/dummy_data.dart';

class AllNotes extends StatelessWidget {
  @override
  @override
  Widget build(BuildContext context) {
    return Consumer<DBprovider>(builder: (context, provider, x) {
      return provider.notes.isEmpty
          ? Center(
              child: Container(
                  width: MediaQuery.of(context).size.width - 40,
                  height: MediaQuery.of(context).size.height - 40,
                  child: Lottie.asset('assets/animation/empty.json')))
          : ListView.builder(
              itemCount: provider.notes.length,
              itemBuilder: (context, index) =>
                  NoteWidget(note: provider.notes[index]));
    });
  }
}
