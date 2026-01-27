import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
      appBar: AppBar(
        title: Text("Profile"),
        iconTheme: IconThemeData(color: Theme.of(context).colorScheme.primary),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        titleTextStyle: TextTheme.of(context).titleLarge?.apply(
          color: brightness == Brightness.light ? Colors.white : Colors.black,
        ),
        centerTitle: true,
      ),
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
                children: [Text(user!['email']), Text(user['username'])],
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
