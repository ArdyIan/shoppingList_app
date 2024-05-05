import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shopping_list/constants/colors.dart';
import 'package:shopping_list/models/note.dart';
import 'package:shopping_list/pages/add_list.dart';
import 'package:shopping_list/theme.dart';

void main() {
  runApp(addList());
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  // HomePage({Key? key}) : super(key: key);
  // final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Note> filteredNotes = [];
  List<String> items = ['Item 1', 'Item 2', 'Item 3'];
  bool sorted = false;

  //function untuk random color pada listview
  getRandomColor() {
    Random random = Random();
    return backgroundColors[random.nextInt(backgroundColors.length)];
  }

  @override
  void initState() {
    super.initState();
    filteredNotes = List.from(sampleNotes);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Shopping List',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.notifications,
            ),
            onPressed: () {},
          )
        ],
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25),
            bottomRight: Radius.circular(25),
          ),
        ),
        backgroundColor: Colors.purple[400],
      ),

      //drawer menu
      drawer: Drawer(
        child: ListView(
          children: [
            ExpansionTile(
              title: Text(
                'Edit',
                style: title3,
              ),
              children: [
                ListTile(
                  title: Text(
                    'Category',
                    style: title4,
                  ),
                  onTap: () {},
                ),
                ListTile(
                  title: Text('Products', style: title4),
                  onTap: () {},
                ),
              ],
            ),
            ExpansionTile(
                title: Text(
              'Lists',
              style: title3,
            )),
            IconButton(
              icon: Icon(
                Icons.settings,
                color: Colors.blueAccent, //default warna hitam abu abu
              ),
              onPressed: () {},
            ),
          ],
        ),
      ),

      //ListVIEW homepage
      body: Expanded(
          child: ListView.builder(
        padding: EdgeInsets.only(top: 30),
        itemCount: sampleNotes.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.only(bottom: 20),
            color: getRandomColor(),
            elevation: 3,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListTile(
                title: RichText(
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    text: TextSpan(
                        text: '${sampleNotes[index].title} \n',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            height: 1.5),
                        children: [
                          TextSpan(
                            text: '${sampleNotes[index].content}',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                                fontSize: 14,
                                height: 1.5),
                          )
                        ])),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    'Edited: ${DateFormat('EEE MMM d, yyyy hh:mm a').format(sampleNotes[index].modifiedTime)}',
                    style: TextStyle(
                        fontSize: 10,
                        fontStyle: FontStyle.italic,
                        color: Colors.blueGrey),
                  ),
                ),
                trailing:
                    IconButton(onPressed: () {}, icon: Icon(Icons.delete)),
              ),
            ),
          );
        },
      )),

//Floating action plus button
//masih error
      floatingActionButton: Builder(
        builder: (BuildContext context) {
          return FloatingActionButton(
            onPressed: () {
              setState(() {
                String lastNoteTitle = sampleNotes.isNotEmpty
                    ? sampleNotes.last.title
                    : 'Catatan Baru';
                Note newNote = Note(
                    id: sampleNotes.length,
                    title: lastNoteTitle,
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
          );
        },
      ),
    );
  }
}

// class addList extends StatelessWidget {
//   @override
//   State<StatefulWidget> createState() {
//     return _addListState();
//   }
// }
