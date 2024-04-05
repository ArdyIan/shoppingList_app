import 'package:flutter/material.dart';
import 'package:shopping_list/theme.dart';
// import 'package:shopping_list/pages/drawer_widget.dart';
// import 'package:shopping_list/pages/drawer_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

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
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: Text(
                'Category',
                style: title3,
              ),
              onTap: () {},
            ),
            ListTile(
              title: Text('Products', style: title3),
              onTap: () {},
            ),
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

      //floating button
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.purple[400],
        shape: CircleBorder(),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),

      body: Column(
        children: [
          Expanded(
              child: SizedBox(
            height: 100,
            child: ListView.separated(
              itemCount: 10, // Ganti dengan jumlah item yang sesuai
              separatorBuilder: (BuildContext context, int index) =>
                  Divider(), // Tambahkan pemisah
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text('Item ${index + 1}'),
                  onTap: () {
                    // Tambahkan logika ketika item diklik
                  },
                );
              },
            ),
          )),
        ],
      ),
    );
  }
}
