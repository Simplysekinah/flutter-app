import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:onboard/Pages/bottom_nav.dart';
import 'package:onboard/Pages/favourite.dart';
import 'package:onboard/Pages/profile.dart';
import 'package:onboard/Pages/tag.dart';
import 'package:onboard/dashboard.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int _currentIndex = 0;

  final pages = [
    Dashboard(),
    TagPage(),
    FavouritePage(),
    ProfilePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stir&Fry'),
      ),
      body: pages[_currentIndex], // Switches between pages
      bottomNavigationBar: CustomBottomNavigation(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('FAB Pressed');
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
