import 'package:flutter/material.dart';
import 'package:proiect_dac/myapp/home_screen/home_page.dart';
import 'package:wakelock/wakelock.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Wakelock.enable();
    return MaterialApp(
      theme: ThemeData.dark(),
      // home: const MyHomePage(),
      home: const HomePage(),
    );
  }
}
