import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:healthcare/screens/welcome_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: 'AIzaSyA51nfZrN5sbnL0HemOPQo6PdmpiNgvs1c',
      projectId: 'sign-up-tubes',
      messagingSenderId: '697035719774',
      appId: '1:697035719774:android:7dc03370e48fa0141020cf',
      databaseURL: 'https://sign-up-tubes-default-rtdb.firebaseio.com',
      authDomain: 'sign-up-tubes.firebaseapp.com',
      storageBucket: 'sign-up-tubes.appspot.com',
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WelcomeScreen(),
    );
  }
}
