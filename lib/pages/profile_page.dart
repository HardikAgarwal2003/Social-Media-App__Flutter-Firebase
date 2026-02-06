import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app_flutter_firebase/components/my_back_button.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  // current logged in users
  final User? currentUser = FirebaseAuth.instance.currentUser;

  // future to fetch user details from firestore
  Future<DocumentSnapshot<Map<String, dynamic>>> getUserDetails() async {
    return await FirebaseFirestore.instance
        .collection("Users")
        .doc(currentUser!.email)
        .get();
  }

  @override
  Widget build(BuildContext context) {
    Brightness brightness = MediaQuery.of(context).platformBrightness;
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Profile"),
      //   iconTheme: IconThemeData(color: Theme.of(context).colorScheme.primary),
      //   backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      //   titleTextStyle: TextTheme.of(context).titleLarge?.apply(
      //     color: brightness == Brightness.light ? Colors.white : Colors.black,
      //   ),
      //   centerTitle: true,
      // ),
      body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        future: getUserDetails(),
        builder: (context, snapshot) {
          // loading circle
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // error
          if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          }

          // data received
          if (snapshot.hasData) {
            // extract data
            Map<String, dynamic>? user = snapshot.data!.data();
            return Center(
              child: Column(
                children: [
                  // My back button
                  Padding(
                    padding: EdgeInsets.only(top: 50, left: 25),
                    child: Row(children: [MyBackButton()]),
                  ),

                  SizedBox(height: 25),

                  // person icon
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: EdgeInsets.all(25),
                    child: Icon(Icons.person_2_rounded, size: 74),
                  ),
                  SizedBox(height: 25),

                  // Username
                  Text(
                    user!['username'],
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),

                  // email
                  Text(
                    user['email'],
                    style: TextStyle(color: Colors.grey[500]),
                  ),
                ],
              ),
            );
          }

          // popping the loading circle
          if (snapshot.connectionState == ConnectionState.done) {
            Navigator.pop(context);
          }

          return Text("No data");
        },
      ),
    );
  }
}
