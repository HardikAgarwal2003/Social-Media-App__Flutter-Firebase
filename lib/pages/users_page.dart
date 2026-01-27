import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app_flutter_firebase/helper/helper_functions.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    Brightness brightness = MediaQuery
        .of(context)
        .platformBrightness;
    return Scaffold(
      appBar: AppBar(
        title: Text("Users"),
        iconTheme: IconThemeData(color: Theme
            .of(context)
            .colorScheme
            .primary),
        backgroundColor: Theme
            .of(context)
            .colorScheme
            .inversePrimary,
        titleTextStyle: TextTheme
            .of(context)
            .titleLarge
            ?.apply(
          color: brightness == Brightness.light ? Colors.white : Colors.black,
        ),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("Users").snapshots(),
        builder: (context, snapshot) {
          // show loading circle
          if (snapshot.connectionState == ConnectionState.waiting) {
            Center(child: CircularProgressIndicator());
          }

          // any error
          if (snapshot.hasError) {
            showMessageToUser("Something went wrong", context);
          }

          if (snapshot.data == null) {
            return const Text("No Data");
          }

          // get all users
          final users = snapshot.data!.docs;
          return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                // get individual user
                final user = users[index];
                return ListTile(
                  title: Text(user["username"]),
                  subtitle: Text(user["email"]),
                );
              });
        },
      ),
    );
  }
}
