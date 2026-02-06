import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app_flutter_firebase/components/my_drawer.dart';
import 'package:social_media_app_flutter_firebase/components/my_list_tile.dart';
import 'package:social_media_app_flutter_firebase/components/my_post_button.dart';
import 'package:social_media_app_flutter_firebase/components/my_text_field.dart';
import 'package:social_media_app_flutter_firebase/database/firestore.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final TextEditingController newPostController = TextEditingController();
  final Firestore database = Firestore();

  void postMessage() {
    if (newPostController.text.isNotEmpty) {
      String message = newPostController.text;
      database.addPost(message);
    }

    newPostController.clear();
  }

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
                Row(
                  children: [
                    Expanded(
                      // Text box for user to type
                      child: MyTextField(
                        hintText: "Say Something...",
                        obscureText: false,
                        controller: newPostController,
                      ),
                    ),

                    // Button to post message
                    MyPostButton(onTap: postMessage),
                  ],
                ),
          ),

          // Posts
          SizedBox(height: 15),
          Expanded(
            child: StreamBuilder(
              stream: database.getPostsStream(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(
                    child: Padding(
                      padding: EdgeInsets.all(25),
                      child: Text("No Posts.. Post something!"),
                    ),
                  );
                }

                final posts = snapshot.data!.docs;

                return ListView.builder(
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    final post = posts[index];

                    String message = post["postMessage"];
                    String userEmail = post["userEmail"];
                    Timestamp ts = post["timeStamp"];
                    DateTime dateTime = ts.toDate();

                    // return ListTile(
                    //   title: Text(
                    //     message,
                    //     style: TextStyle(fontWeight: FontWeight.w600),
                    //   ),
                    //   subtitle: Text(userEmail),
                    //   trailing: Text(
                    //     "${dateTime.day}/${dateTime.month} "
                    //         "${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}",
                    //     style: TextStyle(fontSize: 12),
                    //   ),
                    // );

                    return MyListTile(
                      title: message,
                      subtitle: userEmail,
                      trailing:
                          "${dateTime.day}/${dateTime.month} "
                          "${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}",
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
