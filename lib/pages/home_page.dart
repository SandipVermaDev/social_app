import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_app/components/my_drawer.dart';
import 'package:social_app/components/my_listtile.dart';
import 'package:social_app/components/my_post_button.dart';
import 'package:social_app/components/my_textfield.dart';
import 'package:social_app/database/firestore.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  //firestore access
  final FirestoreDatabase firestoreDatabase = FirestoreDatabase();

  final TextEditingController newPostController = TextEditingController();

  //post message
  postMessage() {
    //only popst message if there is something in textfield
    if (newPostController.text.isNotEmpty) {
      String message = newPostController.text;
      firestoreDatabase.addPost(message);
    }
    //clear controller
    newPostController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("W A L L"),
        backgroundColor: Colors.transparent,
        // foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      drawer: const MyDrawer(),
      body: Column(
        children: [
          //textfield for uer to type
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Row(
              children: [
                Expanded(
                  child: MyTextfield(
                      hintText: "Say something..",
                      obscureText: false,
                      controller: newPostController),
                ),
                MyPostButton(onTap: postMessage)
              ],
            ),
          ),

          //posts
          StreamBuilder(
            stream: firestoreDatabase.getPostStream(),
            builder: (context, snapshot) {
              //show loading circle
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              //get all posts
              final posts = snapshot.data!.docs;

              //no data?
              if (snapshot.data == null || posts.isEmpty) {
                return Center(
                  child: Padding(
                    padding: EdgeInsets.all(25),
                    child: Text("No Posts.. Post Something..!"),
                  ),
                );
              }

              //return as a list
              return Expanded(
                  child: ListView.builder(
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  //get each individual posts
                  final post = posts[index];

                  //get data from each post
                  String message = post['PostMessage'];
                  String userEmail = post['Useremail'];
                  Timestamp timestamp = post['TimeStamp'];

                  //return as a lits tile
                  return MyListtile(title: message, subtitle: userEmail);
                },
              ));
            },
          )
        ],
      ),
    );
  }
}
