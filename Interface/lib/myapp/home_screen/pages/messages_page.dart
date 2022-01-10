import 'package:flutter/material.dart';

class MessagesPage extends StatelessWidget {
  const MessagesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => const Scaffold(
        // appBar: AppBar(
        //   title: const Text('Home'),
        //   backgroundColor: Colors.white,
        //   centerTitle: true,
        // ),
        body: Center(
          child: Text(
            'Messages',
            style: TextStyle(fontSize: 48),
          ),
        ),
      );
}
