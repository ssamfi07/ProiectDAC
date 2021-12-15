import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => const Scaffold(
        // appBar: AppBar(
        //   title: const Text('Home'),
        //   backgroundColor: Colors.white,
        //   centerTitle: true,
        // ),
        body: Center(
          child: Text(
            'Settings',
            style: TextStyle(fontSize: 48),
          ),
        ),
      );
}
