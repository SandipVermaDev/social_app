import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:social_app/auth/auth.dart';
import 'package:social_app/auth/login_or_register.dart';
import 'package:social_app/firebase_options.dart';
import 'package:social_app/theme/dark_mode.dart';

import 'theme/light_mode.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: lightMode,
      darkTheme: darkMode,
      // home: const LoginOrRegister(),
      home: const AuthPage(),
    );
  }
}
