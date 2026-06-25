import 'package:flutter/material.dart';
<<<<<<< Updated upstream

import '../../features/home/dev_menu_screen.dart';
=======
>>>>>>> Stashed changes
import '../../features/login/login_screen.dart';
import '../../features/auth/auth_screen.dart';
import '../../features/home/home_screen.dart';
import '../../features/search_donor/search_donor_screen.dart';
import '../../features/chat/chat_screen.dart';

class AppRoutes {
  static const String login = '/'; 
  static const String auth = '/auth';
  static const String homePage = '/home-page';
  static const String searchDonor = '/search-donor';
  static const String chat = '/chat';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      login: (context) => const LoginScreen(),
      auth: (context) => const AuthScreen(),
      homePage: (context) => const HomeScreen(),
      searchDonor: (context) => const SearchDonorScreen(),
      chat: (context) => const ChatScreen(),
    };
  }
}