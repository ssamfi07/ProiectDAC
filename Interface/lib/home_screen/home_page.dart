// ignore_for_file: import_of_legacy_library_into_null_safe

import 'dart:io';

import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proiect_dac/pages/home_page.dart';
import 'package:proiect_dac/pages/map_page.dart';
import 'package:proiect_dac/pages/map_page2.dart';
import 'package:proiect_dac/pages/messages_page.dart';
import 'package:proiect_dac/pages/settings_page.dart';
import 'package:proiect_dac/Screens/login/login.dart';
import 'package:proiect_dac/pages/googlemaps.dart';
import 'package:cross_local_storage/cross_local_storage.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  final int index;
  const HomePage(this.index);

  @override
  _HomePageState createState() => _HomePageState(index);
}

class _HomePageState extends State<HomePage> {
  int index = 0;
  late final String? name;
  late final String? email;
  // ignore: non_constant_identifier_names
  _HomePageState(this.index) {
    userContext();
  }

  Future userContext() async {
    // prepare storage
    LocalStorageInterface storage = await LocalStorage.getInstance();
    dynamic data = storage.getString("token");
    if (data != null) {
      // fetch user info
      var url = Uri.parse("http://localhost:3000/getInfo");
      print(data);
      var headers = {HttpHeaders.authorizationHeader: data.toString()};

      var response = await http.get(url, headers: headers);

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      // name = response.body.username;
    } else {
      name = 'N/A';
      email = 'N/A';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu'),
      ),
      body: buildPages(),
      bottomNavigationBar: buildBottomNavigationBar(),
      drawer: SizedBox(
        width: MediaQuery.of(context).size.width * 0.75,
        child: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              const UserAccountsDrawerHeader(
                accountName: Text(""), // TODO
                accountEmail: Text(""), // TODO
                decoration: BoxDecoration(color: Colors.black),
                currentAccountPicture: CircleAvatar(
                  radius: 50.0,
                  backgroundColor: Color(0xFF778899),
                  backgroundImage: NetworkImage(""),
                ),
              ),
              ListTile(
                leading: const Icon(
                  Icons.account_box,
                ),
                title: const Text(
                  'Account',
                ),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(
                  Icons.settings,
                ),
                title: const Text(
                  'Settings',
                ),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(
                  // Icons.add_shopping_cart,
                  Icons.local_grocery_store,
                ),
                title: const Text('Remove Ads'),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildBody() => const Center(
        child: Text(
          'Animated Bottom Navigation',
          style: TextStyle(fontSize: 32),
          textAlign: TextAlign.center,
        ),
      );

  Widget buildBottomNavigationBar() {
    const inactiveColor = Colors.grey;
    const activeColor = Colors.white;
    return BottomNavyBar(
      backgroundColor: Colors.black,
      selectedIndex: index,
      onItemSelected: (index) => setState(() => this.index = index),
      items: <BottomNavyBarItem>[
        BottomNavyBarItem(
          icon: const Icon(Icons.account_box),
          title: const Text('Account'),
          textAlign: TextAlign.center,
          inactiveColor: inactiveColor,
          activeColor: activeColor,
        ),
        BottomNavyBarItem(
          icon: const Icon(Icons.location_on_sharp),
          title: const Text('Map'),
          textAlign: TextAlign.center,
          inactiveColor: inactiveColor,
          activeColor: activeColor,
        ),
        BottomNavyBarItem(
          icon: const Icon(Icons.notifications),
          title: const Text('Notifications'),
          textAlign: TextAlign.center,
          inactiveColor: inactiveColor,
          activeColor: activeColor,
        ),
        BottomNavyBarItem(
          icon: const Icon(Icons.settings),
          title: const Text('Settings'),
          textAlign: TextAlign.center,
          inactiveColor: inactiveColor,
          activeColor: activeColor,
        ),
      ],
    );
  }

  buildPages() {
    switch (index) {
      case 0:
        return Login();
      case 1:
        // return const MapPage();
        // return SimpleMapWithPopups();
        return MapScreen();
      case 2:
        return const MessagesPage();
      case 3:
        return const SettingsPage();
      default:
        return const MyHomePage();
    }
  }
}
