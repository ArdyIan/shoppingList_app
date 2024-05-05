import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shopping_list/models/note.dart';

void main() {
  runApp(addList());
}

class addList extends StatefulWidget {
   addList({super.key});
  @override
  // State<addList> createState() => _addListState();
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _addListState();
  }
}



class _addListState extends State<addList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FloatingActionButton(
            onPressed: () {
              setState(() {
                    Note newNote = Note(
                        id: sampleNotes.length,
                        title: 'Catatan Baru',
                        content: 'Isi',
                        modifiedTime: DateTime.now());

                    sampleNotes.add(newNote);
                  });
            },
            backgroundColor: Colors.purple[400],
            shape: CircleBorder(),
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
      ),
      ],
    );
  }
}
