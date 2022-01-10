import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proiect_dac/myapp/Screens/login/login.dart';
import 'package:proiect_dac/myapp/Screens/register/register.dart';
import 'package:proiect_dac/myapp/home_screen/pages/home_page.dart';
import 'package:proiect_dac/myapp/home_screen/pages/map_page.dart';
import 'package:proiect_dac/myapp/home_screen/pages/messages_page.dart';
import 'package:proiect_dac/myapp/home_screen/pages/settings_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 0;

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
                accountName: Text("Mona"),
                accountEmail: Text("MonaLisa@gmail.com"),
                decoration: BoxDecoration(color: Colors.black),
                currentAccountPicture: CircleAvatar(
                  radius: 50.0,
                  backgroundColor: Color(0xFF778899),
                  backgroundImage:
                      NetworkImage("http://tineye.com/images/widgets/mona.jpg"),
                ),
              ),
              // const DrawerHeader(
              //   child: Text('Menu'),
              //   decoration: BoxDecoration(
              //     color: Colors.blue,
              //   ),
              // ),
              ListTile(
                leading: const Icon(
                  Icons.account_box,
                ),
                title: const Text(
                  'Account',
                ),
                onTap: () {
                  // Update the state of the app.
                  // ...
                  index = 4;
                  print('page index is: ' + index.toString());
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.settings,
                ),
                title: const Text(
                  'Settings',
                ),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
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
          icon: const Icon(Icons.apps),
          title: const Text('Home'),
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
        return const MyHomePage();
      case 1:
        return const MapPage();
      case 2:
        return const MessagesPage();
      case 3:
        return const SettingsPage();
      case 4:
        return const LoginScreen();
      case 5:
        return RegisterScreen();
      default:
        return const MyHomePage();
    }
  }
}
