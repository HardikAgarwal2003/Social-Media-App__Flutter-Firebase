import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app_flutter_firebase/auth/auth.dart';
import 'package:social_media_app_flutter_firebase/auth/login_or_register.dart';
import 'package:social_media_app_flutter_firebase/firebase_options.dart';
import 'package:social_media_app_flutter_firebase/pages/home_page.dart';
import 'package:social_media_app_flutter_firebase/pages/profile_page.dart';
import 'package:social_media_app_flutter_firebase/pages/users_page.dart';
import 'package:social_media_app_flutter_firebase/theme/dark_theme.dart';
import 'package:social_media_app_flutter_firebase/theme/light_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const AuthPage(),
      theme: lightMode,
      darkTheme: darkMode,
      routes: {
        '/login_register_page' :(context) => const LoginOrRegister(),
        '/home_page' : (context) => const HomePage(),
        '/profile_page' : (context) => ProfilePage(),
        '/users_page': (context) => const UsersPage()
      },
    );
  }
}
