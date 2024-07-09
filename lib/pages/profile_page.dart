import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_app/components/my_back_button.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  //current logged in user
  User? currentUser=FirebaseAuth.instance.currentUser;

  //fetch user details
  Future<DocumentSnapshot<Map<String,dynamic>>> getUserDetails()async{
    return FirebaseFirestore.instance
        .collection("Users")
        .doc(currentUser!.email)
        .get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      //   title: Text("Profile"),
      //   centerTitle: true,
      // ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: FutureBuilder<DocumentSnapshot<Map<String,dynamic>>>(future: getUserDetails(), builder: (context, snapshot) {
        //loading
        if(snapshot.connectionState==ConnectionState.waiting){
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        //error
        else if(snapshot.hasError){
          return Text("Error ${snapshot.error}");
        }
        //data received
        else if(snapshot.hasData){
          //extract data
          Map<String,dynamic>? user=snapshot.data!.data();

          return SafeArea(
            child: Center(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Row(
                      children: [
                        MyBackButton(),
                      ],
                    ),
                  ),
                  SizedBox(height: 25,),

                  // CircleAvatar(
                  //   backgroundColor: Theme.of(context).colorScheme.primary,
                  //   radius: 70,
                  //   child: const Icon(Icons.person,size: 80,),
                  // ),
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(24)
                    ),
                    padding: EdgeInsets.all(30),
                    child: Icon(Icons.person,size: 70,),
                  ),
                  const SizedBox(height: 30,),
                  Text(user!["username"],style: const TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
                  const SizedBox(height: 10,),
                  Text(user["email"],style: const TextStyle(fontSize: 20),)
                ],
              ),
            ),
          );
        }
        else{
          return const Text("No data");
        }

      },),
    );
  }
}
