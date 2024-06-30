import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopping_list/pages/home_page.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePageApp(),
                  ));
            },
            icon: Icon(Icons.arrow_back)),
        title: Text(
          "Setting",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.all(10),
        child: ListView(
          children: [
            SizedBox(
              height: 40,
            ),
            Row(
              children: [
                Icon(
                  Icons.person,
                  color: Colors.blue,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "Profile Setting",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                )
              ],
            ),
            Divider(
              height: 20,
              thickness: 1,
            ),
            SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {},
              child: ListTile(
                leading: Icon(Icons.person_2_rounded),
                title: Text("Change Account"),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {},
              child: ListTile(
                leading: Icon(Icons.password),
                title: Text("Change Password"),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {},
              child: ListTile(
                leading: Icon(Icons.archive_outlined),
                title: Text("Arsip"),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ListTile(
              leading: Icon(
                Icons.delete_outline,
                color: Colors.black,
              ),
              title: Text(
                "Sampah",
                style: TextStyle(color: Colors.black),
              ),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(
                Icons.thumb_up_alt_outlined,
                color: Colors.black,
              ),
              title: Text(
                "Rate",
                style: TextStyle(color: Colors.black),
              ),
              onTap: () {},
            ),
            SizedBox(
              height: 10,
            ),
            ListTile(
              leading: Icon(
                Icons.share,
                color: Colors.black,
              ),
              title: Text(
                "Share",
                style: TextStyle(color: Colors.black),
              ),
              onTap: () {},
            ),
            GestureDetector(
              onTap: () {},
              child: ListTile(
                leading: Icon(Icons.question_mark_outlined),
                title: Text("Bantuan & masukan"),
              ),
            ),
            Divider(
              height: 2,
              thickness: 1,
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20))),
                onPressed: () {},
                child: Text(
                  "LOG OUT",
                  style: TextStyle(
                      fontSize: 16, letterSpacing: 2.2, color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
