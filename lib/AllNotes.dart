import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'NoteWidget.dart';
import 'model/dummy_data.dart';

class AllNotes extends StatelessWidget {
  const AllNotes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: Notes.length,
        itemBuilder: (context, index) => NoteWidget(Notes[index]));
  }
}
