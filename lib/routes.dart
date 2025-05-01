import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:onboard/dashboard.dart';
import 'package:onboard/main.dart';
import 'package:onboard/onboardingScreen.dart';
import 'package:onboard/widget.dart';

/// The route configuration.
final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const MyHomePage(
          title: 'welcome',
        );
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'onboarding',
          builder: (BuildContext context, GoRouterState state) {
            return Onboardingscreen();
          },
        ),
        GoRoute(
          path: '/dashboard',
          builder: (BuildContext context, GoRouterState state) {
            return Dashboard();
          },
        ),
      ],
    ),
  ],
);
