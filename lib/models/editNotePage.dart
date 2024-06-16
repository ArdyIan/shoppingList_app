import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'note.dart';

class EditNotePage extends StatefulWidget {
  const EditNotePage({super.key});
  // final Note note;

  // const EditNotePage({required this.note});
  @override
  State<EditNotePage> createState() => _editNotePage();
}

class _editNotePage extends State<EditNotePage> {
  TextEditingController titleController = TextEditingController();
  List<TextEditingController> listController = [TextEditingController()];
  List<bool> isChecked = [false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
              height: 15,
            ),
//listview untuk list barang
            ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 15),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: listController.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(top: 15),
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
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          height: 60,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: const Color(0xFF2E384E),
                            borderRadius: BorderRadius.circular(10),
                          ),
//Bagian title
                          child: TextFormField(
                              controller: listController[index],
                              autofocus: false,
                              style: const TextStyle(color: Color(0xFFF8F8FF)),
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Input Text Here",
                                  hintStyle: TextStyle(
                                      color: Color.fromARGB(
                                          255, 132, 140, 155))))),
                    ),
                    const SizedBox(
                      width: 10,
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
                        size: 35,
                      ),
                    )
                    // : const SizedBox()
                  ]),
                );
              },
            ),
            const SizedBox(
              height: 50,
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
            )
          ],
        ),
      )),
    );
  }
}
