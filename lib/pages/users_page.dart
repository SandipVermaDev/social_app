import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:social_app/components/my_listtile.dart';
import 'package:social_app/helper/helper_function.dart';

import '../components/my_back_button.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      //   title: const Text("Users"),
      //   centerTitle: true,
      // ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("Users").snapshots(),
          builder: (context, snapshot) {
            //any errors
            if(snapshot.hasError){
              displayMessageToUser("Something went wrong.", context);
            }

            //show loading
            if(snapshot.connectionState== ConnectionState.waiting){
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if(snapshot.data==null){
              return const Text("No data");
            }

            //get all users
            final users= snapshot.data!.docs;
            return SafeArea(
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(25.0),
                    child: Row(
                      children: [
                        MyBackButton(),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: users.length,
                      padding: const EdgeInsets.all(0),
                      itemBuilder: (context, index) {
                      //get individual user
                        final user=users[index];
                        return MyListtile(title: user['username'], subtitle: user['email']);
                        //   ListTile(
                        //   title: Text(user['username']),
                        //   subtitle: Text(user['email']),
                        // );
                    },),
                  ),
                ],
              ),
            );
          },),
    );
  }
}
