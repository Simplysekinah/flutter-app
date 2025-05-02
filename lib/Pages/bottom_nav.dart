// custom_bottom_navigation.dart

import 'package:flutter/material.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';

class CustomBottomNavigation extends StatefulWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavigation({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  _CustomBottomNavigationState createState() => _CustomBottomNavigationState();
}

class _CustomBottomNavigationState extends State<CustomBottomNavigation> {
  final iconList = <IconData>[
    Icons.home,
    Icons.search,
    Icons.favorite,
    Icons.person,
  ];

  @override
  Widget build(BuildContext context) {
    return AnimatedBottomNavigationBar(
      icons: iconList,
      activeIndex: widget.currentIndex,
      gapLocation: GapLocation.center,
      activeColor: Colors.blue,
      inactiveColor: Colors.grey,
      notchSmoothness: NotchSmoothness.softEdge,
      onTap: widget.onTap,
      backgroundColor: Colors.white,
      splashSpeedInMilliseconds: 300,
    );
  }
}
