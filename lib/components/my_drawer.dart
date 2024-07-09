import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_app/pages/profile_page.dart';
import 'package:social_app/pages/users_page.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  //logout
  logout() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              //drawer haeder
              DrawerHeader(
                child: Icon(
                  Icons.favorite,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
              SizedBox(
                height: 25,
              ),

              //home tile
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  leading: Icon(
                    Icons.home,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                  title: Text("H O M E"),
                  onTap: () {
                    //this is already home page so just pop drawer
                    Navigator.pop(context);
                  },
                ),
              ),

              //profile tile
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  leading: Icon(
                    Icons.person,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                  title: Text("P R O F I L E"),
                  onTap: () {
                    //pop drawer
                    Navigator.pop(context);

                    //navigate to profile page
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage()));
                  },
                ),
              ),

              //users tile
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  leading: Icon(
                    Icons.group,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                  title: Text("U S E R S"),
                  onTap: () {
                    //pop drawer
                    Navigator.pop(context);

                    //navigate to users page
                    Navigator.push(context, MaterialPageRoute(builder: (context) => UsersPage(),));
                  },
                ),
              ),
            ],
          ),

          //logout
          Padding(
            padding: const EdgeInsets.only(left: 25.0,bottom: 25),
            child: ListTile(
              leading: Icon(
                Icons.home,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
              title: Text("L O G O U T"),
              onTap: () {
                //pop drawer
                Navigator.pop(context);
                logout();
              },
            ),
          )
        ],
      ),
    );
  }
}
