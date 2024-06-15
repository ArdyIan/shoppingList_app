import 'package:flutter/material.dart';
import 'note.dart';

class EditNotePage extends StatelessWidget {
  final Note note;

  const EditNotePage({required this.note});

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController =
        TextEditingController(text: note.title);
    TextEditingController contentController =
        TextEditingController(text: note.content);

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Note'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: 'Title',
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: contentController,
              maxLines: null,
              expands: true,
              decoration: InputDecoration(
                labelText: 'Content',
                alignLabelWithHint: true,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Panggil metode editNote untuk mengubah catatan
                note.editNote(titleController.text, contentController.text);
                Navigator.pop(context); // Kembali ke halaman sebelumnya
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
