import 'package:flutter/material.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => const Scaffold(
        // appBar: AppBar(
        //   title: const Text('Home'),
        //   backgroundColor: Colors.white,
        //   centerTitle: true,
        // ),
        body: Center(
          child: Text(
            'Users',
            style: TextStyle(fontSize: 48),
          ),
        ),
      );
}
