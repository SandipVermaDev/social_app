import 'package:flutter/material.dart';

//display error to user
displayMessageToUser(String message,BuildContext context){
  showDialog(context: context, builder: (context) => AlertDialog(
    title: Text(message),
    titlePadding: const EdgeInsets.all(25),
    actions: [
      ElevatedButton(onPressed: () {
        Navigator.pop(context);
      }, child: Text("Ok",style: TextStyle(color: Theme.of(context).colorScheme.secondary)))
    ],
  ),);
}