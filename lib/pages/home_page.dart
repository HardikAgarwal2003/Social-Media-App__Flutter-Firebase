import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app_flutter_firebase/components/my_drawer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void logoutUser() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    Brightness brightness = MediaQuery.of(context).platformBrightness;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Theme.of(context).colorScheme.primary),
        title: Center(child: Text("Home")),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        titleTextStyle: TextTheme.of(context).titleLarge?.apply(color: brightness == Brightness.light ? Colors.white : Colors.black,),
        // titleTextStyle: TextStyle(
        //   color: brightness == Brightness.light ? Colors.white : Colors.black,
        // ),
        actions: [IconButton(onPressed: logoutUser, icon: Icon(Icons.logout))],
      ),
      drawer: MyDrawer(brightness: brightness),
    );
  }
}
