import 'package:flutter/material.dart';
import 'package:social_media_app_flutter_firebase/components/my_drawer.dart';
import 'package:social_media_app_flutter_firebase/components/my_text_field.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final TextEditingController newPostController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Brightness brightness = MediaQuery.of(context).platformBrightness;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Theme.of(context).colorScheme.inversePrimary,
        ),
        title: Text("P O S T S"),
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        // titleTextStyle: TextTheme.of(context).titleLarge?.apply(
        //   color: brightness == Brightness.light ? Colors.white : Colors.black,
        // ),
        centerTitle: true,
      ),

      drawer: MyDrawer(brightness: brightness),

      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child:
                // TextField box for users to type
                MyTextField(
                  hintText: "Say Something...",
                  obscureText: false,
                  controller: newPostController,
                ),

            // Posts
          ),
        ],
      ),
    );
  }
}
