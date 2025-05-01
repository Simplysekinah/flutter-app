import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:onboard/vaiable.dart';
import 'package:onboard/widget.dart';

class Onboardingscreen extends StatefulWidget {
  const Onboardingscreen({super.key});

  @override
  State<Onboardingscreen> createState() => _OnboardingscreenState();
}

class _OnboardingscreenState extends State<Onboardingscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: onboardController,
        pageSnapping: true,
        scrollDirection: Axis.horizontal,
        onPageChanged: (value) {},
        children: [
          OnboardScreen(
            title: 'Welcome to Stir&Fry',
            images: 'lib/asset/food1.jpg',
          ),
          OnboardScreen(
            title: 'A place for delicioes food',
            images: 'lib/asset/food2.jpg',
          ),
          OnboardScreen(
            title: 'Enjoy every taste',
            images: 'lib/asset/food3.jpg',
          ),
          OnboardScreen(
            title: 'Satisfy all cravings',
            images: 'lib/asset/food2.jpg',
          ),
          OnboardScreenTwo(
            title: 'Welcome to Stir&Fry',
            images: 'lib/asset/foodrecipes.jpg',
          )
        ],
      ),
    );
  }
}
