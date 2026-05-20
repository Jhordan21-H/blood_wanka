import 'package:flutter/material.dart';
import '../../features/home/dev_menu_screen.dart';
import '../../features/login/login_screen.dart';
import '../../features/auth/auth_screen.dart';
import '../../features/home/home_screen.dart';
import '../../features/search_donor/search_donor_screen.dart';

class AppRoutes {
  static const String initial = '/';
  static const String login = '/login';
  static const String auth = '/auth';
  static const String homePage = '/home-page';
  static const String searchDonor = '/search-donor';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      initial: (context) => const DevMenuScreen(),
      login: (context) => const LoginScreen(),
      auth: (context) => const AuthScreen(),
      homePage: (context) => const HomeScreen(),
      searchDonor: (context) => const SearchDonorScreen(),
    };
  }
}