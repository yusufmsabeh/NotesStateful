import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

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
    return ListView.builder(
        itemCount: widget.notes.length,
        itemBuilder: (context, index) =>
            NoteWidget(widget.notes[index], Refresh));
  }
}
