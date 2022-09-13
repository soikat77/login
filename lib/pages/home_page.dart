import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login/read_data/get_user_name.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // getting the user
  final user = FirebaseAuth.instance.currentUser!;

  // documents ID
  List<String> docID = [];

  // get docID
  Future getDocID() async {
    await FirebaseFirestore.instance.collection('users').get().then(
          (value) => value.docs.forEach(
            (element) {
              docID.add(element.reference.id);
            },
          ),
        );
  }

  // @override
  // void initState() {
  //   getDocID();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text(user.email!),
        actions: [
          GestureDetector(
            onTap: () {
              FirebaseAuth.instance.signOut();
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 18.0),
              child: Icon(
                Icons.logout,
                size: 22,
              ),
            ),
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                child: FutureBuilder(
              future: getDocID(),
              builder: (context, snapshot) {
                return ListView.builder(
                  itemCount: docID.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: GetUserName(documentID: docID[index]),
                    );
                  },
                );
              },
            )),
          ],
        ),
      ),
    );
  }
}
