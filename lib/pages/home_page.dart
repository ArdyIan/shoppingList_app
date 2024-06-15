import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:shopping_list/constants/colors.dart';
import 'package:shopping_list/models/note.dart';
import 'package:shopping_list/theme.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:shopping_list/models/editNotePage.dart';

void main() {
  runApp(HomePageApp());
}

class HomePageApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shopping List',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Note> filteredNotes = [];
  List<String> items = ['Item 1', 'Item 2', 'Item 3'];
  bool sorted = false;

  //function untuk random color pada listview
  Color getRandomColor() {
    Random random = Random();
    return backgroundColors[random.nextInt(backgroundColors.length)];
  }

  @override
  void initState() {
    super.initState();
    filteredNotes = List.from(sampleNotes);
  }

  //logika untuk mengedit item dengan menavigasi ke halaman editNotePage
  void editItem(Note note) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditNotePage(note: note),
      ),
    ).then((updatedNote) {
      if (updatedNote != null) {
        setState(() {
          int index = filteredNotes.indexWhere((n) => n.id == updatedNote.id);
          if (index != -1) {
            filteredNotes[index] = updatedNote;
          }
        });
      }
    });
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
            icon: const Icon(Icons.notifications),
            onPressed: () {},
          )
        ],
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
//membuat tepian menjadi tumpul
              // bottomLeft: Radius.circular(25),
              // bottomRight: Radius.circular(25),
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
                color: Colors.blueAccent,
              ),
              onPressed: () {},
            ),
          ],
        ),
      ),

// ListVIEW homepage
// berubah jadi grouped listview
      body: GroupedListView<Note, DateTime>(
        elements: filteredNotes,
        groupBy: (note) => DateTime(note.modifiedTime.year,
            note.modifiedTime.month, note.modifiedTime.day),
        groupSeparatorBuilder: (DateTime date) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            DateFormat.yMMMd().format(date),
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        itemBuilder: (context, Note note) {
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
                    text: '${note.title} \n',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      height: 1.5,
                    ),
                    children: [
                      TextSpan(
                        text: '${note.content}',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                          fontSize: 14,
                          height: 1.5,
                        ),
                      )
                    ],
                  ),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    'Edited: ${DateFormat('EEE MMM d, yyyy hh:mm a').format(note.modifiedTime)}',
                    style: TextStyle(
                      fontSize: 10,
                      fontStyle: FontStyle.italic,
                      color: Colors.blueGrey,
                    ),
                  ),
                ),
                trailing: SizedBox(
                  width: 24,
                  child: Icon(Icons.arrow_forward),
                ),
//clickable listview untuk mengubah isi di dalam listview
//MASIH ERROR
                // onTap: () {
                //   editItem(note);
                // },
              ),
            ),
          );
        },
        itemComparator: (item1, item2) =>
            item1.modifiedTime.compareTo(item2.modifiedTime),
        useStickyGroupSeparators: true,
        floatingHeader: true,
        order: GroupedListOrder.ASC,
      ),
//floating action button
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple[400],
        onPressed: () {
          setState(() {
            Note newNote = Note(
              id: filteredNotes.length,
              title: 'Catatan Baru',
              content: 'Isi',
              modifiedTime: DateTime.now(),
            );
            filteredNotes.add(newNote);
          });
        },
//floating action button plus
        shape: CircleBorder(),
        tooltip: 'increment',
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
//bottom navigator bawah dengan icon dan floating button
      bottomNavigationBar: SizedBox(
        height: 60,
        child: BottomAppBar(
          color: Colors.purple[400],
          shape: CircularNotchedRectangle(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.home,
                  // color: Colors.purple[400],
                ),
              ),
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.settings,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
