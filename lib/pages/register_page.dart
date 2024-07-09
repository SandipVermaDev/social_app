import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_app/components/my_button.dart';
import 'package:social_app/components/my_textfield.dart';
import 'package:social_app/helper/helper_function.dart';
import 'package:social_app/pages/login_page.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;

  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController usernameConroller = TextEditingController();
  final TextEditingController emailConroller = TextEditingController();
  final TextEditingController passwordConroller = TextEditingController();
  final TextEditingController confirmPasswordConroller =
      TextEditingController();

  //register
  registerUser() async {
    //show Loading circle
    showDialog(
      context: context,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    //make sure password match
    if (passwordConroller.text != confirmPasswordConroller.text) {
      //pop loading circle
      Navigator.pop(context);

      //show error massage to user
      displayMessageToUser("Passwords Don't Match!", context);
    }
    //if pass word match
    else {
      //try creating the user
      try {
        //create the user
        UserCredential userCredential= await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailConroller.text, password: passwordConroller.text);

        //create a user document and add to firestore
        createUserDocument(userCredential);

        //pop loading circle
        if(context.mounted)Navigator.pop(context);
      } on FirebaseAuthException catch (e) {
        //pop loading circle
        Navigator.pop(context);

        //display error massage
        displayMessageToUser(e.code, context);
      }
    }
  }

  //create user document
  createUserDocument(UserCredential userCredential) async {
    if(userCredential!=null && userCredential.user!=null){
      await FirebaseFirestore.instance.collection("Users").doc(userCredential.user!.email).set({
            'email':userCredential.user!.email,
        'username':usernameConroller.text
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Center(
            child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //logo
              Icon(
                Icons.person,
                size: 80,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
              const SizedBox(
                height: 25,
              ),

              //app name
              const Text(
                "M I N I M A L",
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(
                height: 50,
              ),

              //username Textfield
              MyTextfield(
                  hintText: "UserName",
                  obscureText: false,
                  controller: usernameConroller),
              const SizedBox(
                height: 25,
              ),

              //email textfield
              MyTextfield(
                  hintText: "Email",
                  obscureText: false,
                  controller: emailConroller),
              const SizedBox(
                height: 25,
              ),

              //password textfield
              MyTextfield(
                  hintText: "Password",
                  obscureText: true,
                  controller: passwordConroller),
              const SizedBox(
                height: 25,
              ),

              //confirmpassword textfield
              MyTextfield(
                  hintText: "Confirm Password",
                  obscureText: false,
                  controller: confirmPasswordConroller),
              const SizedBox(
                height: 40,
              ),

              //register button
              MyButton(text: "Register", onTap: registerUser),
              const SizedBox(
                height: 25,
              ),

              //If already have an account? Login here
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account?",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary),
                  ),
                  GestureDetector(
                    onTap: widget.onTap,
                    // onTap: () {
                    //   Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage(),));
                    // },
                    child: const Text(
                      "Login here",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              )
            ],
          ),
        )),
      ),
    );
  }
}
