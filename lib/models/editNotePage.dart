import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopping_list/models/note.dart';
import 'package:shopping_list/pages/home_page.dart';
// import 'note.dart';

class EditNotePage extends StatefulWidget {
  // const EditNotePage({super.key});
  final Note note;

  EditNotePage({required this.note});

  // const EditNotePage({required this.note});
  @override
  State<EditNotePage> createState() => _editNotePage();
}

class _editNotePage extends State<EditNotePage> {
  late TextEditingController titleController;
  late List<TextEditingController> listController;
  late List<bool> isChecked;
  late TextEditingController _titleController;
  late TextEditingController _contentController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.note.title);
    listController = widget.note.items
        .map((item) => TextEditingController(text: item.content))
        .toList();
    isChecked = widget.note.items.map((item) => item.isChecked).toList();
  }

  @override
  void dispose() {
    titleController.dispose();
    for (var controller in listController) {
      controller.dispose();
    }
    super.dispose();
  }

  void _saveNote() {
    setState(() {
      widget.note.title = titleController.text;
      widget.note.items = listController
          .asMap()
          .entries
          .map((entry) => NoteItem(
                content: entry.value.text,
                isChecked: isChecked[entry.key],
              ))
          .toList();
      widget.note.modifiedTime = DateTime.now();
    });
    Navigator.pop(context, widget.note);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              _saveNote();
            },
            icon: Icon(Icons.arrow_back)),
        title: Text(
          "List",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextField(
                controller: titleController,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Enter Title",
                    hintStyle: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey,
                    )),
              ),
              // child: Text(
              //   "Title",
              //   style: GoogleFonts.poppins(
              //     fontWeight: FontWeight.bold,
              //     color: Colors.blueGrey,
              //   ),
              // ),
            ),
            const SizedBox(
              height: 5,
            ),
//listview untuk list barang
            ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 5),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: listController.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Row(children: [
                    Checkbox(
                        value: isChecked[index],
                        onChanged: (bool? value) {
                          setState(() {
                            isChecked[index] = value!;
                          });
                        }),
                    Expanded(
                      child: Container(
                          //padding: const EdgeInsets.symmetric(horizontal: 10),
                          height: 40,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xFF2E384E)),
                            borderRadius: BorderRadius.circular(10),
                          ),
//Bagian title
                          child: TextFormField(
                            controller: listController[index],
                            autofocus: false,
                            // keyboardType: TextInputType.multiline,
                            // minLines: 1,
                            // maxLines: 10,
                            style: const TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                              hintText: "Input Text Here",
                              hintStyle: TextStyle(
                                color: Color.fromARGB(255, 132, 140, 155),
                              ),
                              contentPadding:
                                  EdgeInsets.symmetric(vertical: 10),
                            ),
                          )),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    // index != 0 ?
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          listController[index].clear();
                          listController[index].dispose();
                          listController.removeAt(index);
                          isChecked.removeAt(index);
                        });
                      },
                      child: const Icon(
                        Icons.delete,
                        color: Color(0xFF6B74D6),
                        size: 25,
                      ),
                    )
                    // : const SizedBox()
                  ]),
                );
              },
            ),
            const SizedBox(
              height: 40,
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  listController.add(TextEditingController());
                  isChecked.add(false);
                });
              },
              child: Center(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  decoration: BoxDecoration(
                      color: const Color(0xFF444C60),
                      borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    "Add More",
                    style: GoogleFonts.nunito(color: const Color(0xFFF8F8FF)),
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
          ],
        ),
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(
            context,
            Note(
              id: widget.note.id,
              title: titleController.text,
              content: listController.map((e) => e.text).join(', '),
              modifiedTime: DateTime.now(),
              items: listController
                  .asMap()
                  .entries
                  .map((entry) => NoteItem(
                        content: entry.value.text,
                        isChecked: isChecked[entry.key],
                      ))
                  .toList(),
            ),
          );
        },
        backgroundColor: Color.fromARGB(255, 227, 246, 255),
        child: Icon(
          Icons.save,
        ),
      ),
    );
  }
}
