import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app_flutter_firebase/helper/helper_functions.dart';

import '../components/my_back_button.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    Brightness brightness = MediaQuery.of(context).platformBrightness;
    return Scaffold(
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

          return Column(
            children: [
              // My back button
              Padding(
                padding: EdgeInsets.only(top: 50, left: 25),
                child: Row(children: [MyBackButton()]),
              ),

              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.only(left: 16),
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    // get individual user
                    final user = users[index];
                    return ListTile(
                      title: Text(user["username"]),
                      subtitle: Text(user["email"]),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
