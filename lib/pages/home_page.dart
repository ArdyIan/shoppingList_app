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
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomePageApp(),
  ));
}

bool toogle = true;

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

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  List<Note> filteredNotes = [];
  List<String> items = ['Item 1', 'Item 2', 'Item 3'];
  bool sorted = false;
  late AnimationController _controller;
  late Animation _animation;

  //function untuk random color pada listview
  Color getRandomColor() {
    Random random = Random();
    return backgroundColors[random.nextInt(backgroundColors.length)];
  }

  @override
  void initState() {
    super.initState();
    filteredNotes = List.from(sampleNotes);

    _controller = AnimationController(
        duration: Duration(milliseconds: 350),
        vsync: this,
        reverseDuration: Duration(milliseconds: 275));

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
      reverseCurve: Curves.easeIn,
    );
    // _controller.forward();
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    // _controller.dispose();
    super.dispose();
  }

  Alignment alignment1 = Alignment.bottomCenter;
  Alignment alignment2 = Alignment.bottomCenter;
  Alignment alignment3 = Alignment.bottomCenter;
  double size1 = 20.0;
  double size2 = 20.0;
  double size3 = 20.0;

  // void _toggleFab() {
  //   setState(() {
  //     toogle = !toogle;
  //     if (toogle) {
  //       _controller.forward();
  //     } else {
  //       _controller.reverse();
  //     }
  //   });
  // }

  //logika untuk mengedit item dengan menavigasi ke halaman editNotePage
  void editItem(Note note) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditNotePage(),
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
        body: Stack(children: [
          GroupedListView<Note, DateTime>(
            shrinkWrap: true,
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
                //bikin listview jadi random color
                // color: getRandomColor(),
                color: Colors.grey[300],
                elevation: 3,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
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
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditNotePage(),
                          ));
                    },
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
          AnimatedAlign(
            duration: toogle
                ? Duration(milliseconds: 275)
                : Duration(milliseconds: 875),
            alignment: alignment1,
            curve: toogle ? Curves.easeIn : Curves.elasticOut,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 275),
              curve: toogle ? Curves.easeIn : Curves.easeOut,
              height: size1,
              width: size1,
              decoration: BoxDecoration(
                color: Colors.black87,
                borderRadius: BorderRadius.circular(40.0),
              ),
              child: Icon(Icons.message, color: Colors.white),
            ),
          ),
          AnimatedAlign(
            duration: toogle
                ? Duration(milliseconds: 275)
                : Duration(milliseconds: 875),
            alignment: alignment2,
            curve: toogle ? Curves.easeIn : Curves.elasticOut,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 275),
              curve: toogle ? Curves.easeIn : Curves.easeOut,
              height: size2,
              width: size2,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(40.0),
              ),
              child: Icon(Icons.message, color: Colors.white),
            ),
          ),
          AnimatedAlign(
            duration: toogle
                ? Duration(milliseconds: 275)
                : Duration(milliseconds: 875),
            alignment: alignment3,
            curve: toogle ? Curves.easeIn : Curves.elasticOut,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 275),
              curve: toogle ? Curves.easeIn : Curves.easeOut,
              height: size3,
              width: size3,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(40.0),
              ),
              child: Icon(Icons.message, color: Colors.white),
            ),
          ),
        ]),

//floating action button
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        // floatingActionButton: FloatingActionButton(
        //     backgroundColor: Colors.purple[400],
        //     onPressed: () {
        //       if (toogle) {
        //         toogle = !toogle;
        //         _controller.forward();
        //         Future.delayed(Duration(milliseconds: 10), () {
        //           alignment1 = Alignment(-0.5, -0.3);
        //           size1 = 50.0;
        //         });
        //         Future.delayed(Duration(milliseconds: 100), () {
        //           alignment2 = Alignment(0.0, -0.5);
        //           size2 = 50.0;
        //         });
        //         Future.delayed(Duration(milliseconds: 200), () {
        //           alignment3 = Alignment(0.5, -0.3);
        //           size3 = 50.0;
        //         });
        //       } else {
        //         toogle = !toogle;
        //         _controller.reverse();
        //         alignment1 = Alignment(0.0, 0.0);
        //         alignment2 = Alignment(0.0, 0.0);
        //         alignment3 = Alignment(0.0, 0.0);
        //         size1 = size2 = size3 = 20.0;
        //       }
        //     },

//floating action button plus
        // shape: CircleBorder(),
        // tooltip: 'increment',

        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              if (toogle) {
                toogle = !toogle;
                _controller.forward();
                Future.delayed(Duration(milliseconds: 10), () {
                  alignment1 = Alignment(-0.5, 0.9);
                  size1 = 50.0;
                });
                Future.delayed(Duration(milliseconds: 100), () {
                  alignment2 = Alignment(0.0, 0.7);
                  size2 = 50.0;
                });
                Future.delayed(Duration(milliseconds: 200), () {
                  alignment3 = Alignment(0.5, 0.9);
                  size3 = 50.0;
                });
              } else {
                toogle = !toogle;
                _controller.reverse();
                alignment1 = Alignment.bottomCenter;
                alignment2 = Alignment.bottomCenter;
                alignment3 = Alignment.bottomCenter;
                size1 = size2 = size3 = 20.0;
              }
            });
          },
          mini: true,
          child: Icon(
            Icons.add,
            color: Colors.black,
          ),
        ),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniCenterDocked,
        //bottom navigator bawah dengan icon dan floating button
        bottomNavigationBar: SizedBox(
          child: BottomAppBar(
            color: Colors.purple,
            shape: CircularNotchedRectangle(),
//menu pada bottom view
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
        ));
    //bottom navigator bawah dengan icon dan floating button
    //bottom navigator bawah dengan icon dan floating button
  }
}
