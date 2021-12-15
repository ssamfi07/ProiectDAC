import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => const Scaffold(
        // appBar: AppBar(
        //   title: const Text('Home'),
        //   backgroundColor: Colors.white,
        //   centerTitle: true,
        // ),
        body: Center(
          child: Text(
            'Home',
            style: TextStyle(fontSize: 48),
          ),
        ),
      );
}
