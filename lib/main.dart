import 'package:flutter/material.dart';
import 'package:sql_example/screens/add_notes.dart';
import 'package:sql_example/screens/home.dart';

bool? islogin;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
      routes: {
        'home': (context) => const HomeScreen(),
        'addNotes': (context) => const AddNotes(),
      },
    );
  }
}
