import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:lottie/lottie.dart';

import 'NoteWidget.dart';
import 'model/note.dart';
import 'model/dummy_data.dart';

class AllNotes extends StatefulWidget {
  late List<Note> notes;

  AllNotes({Key? key, required this.notes}) : super(key: key);

  @override
  State<AllNotes> createState() => _AllNotesState();
}

class _AllNotesState extends State<AllNotes> {
  void Refresh() {
    print("Refresh in the allnotes screen");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (Notes.isEmpty) {
      return Center(
          child: Container(
              width: MediaQuery.of(context).size.width - 40,
              height: MediaQuery.of(context).size.height - 40,
              child: Lottie.asset('assets/animation/empty.json')));
    }
    return ListView.builder(
        itemCount: widget.notes.length,
        itemBuilder: (context, index) =>
            NoteWidget(widget.notes[index], Refresh));
  }
}
