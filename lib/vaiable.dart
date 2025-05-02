import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:onboard/functiondio.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

final FlutterSecureStorage storage = FlutterSecureStorage();
final counterProvider = StateProvider((ref) => 0);
final firstRunProvider = StateProvider<bool>((ref) => false);
PageController onboardController = PageController();
StateProvider<bool> ifr = StateProvider((ref) => false);
bool isInit = false;
// Future<Map<String, dynamic>> prod() async => await result();
