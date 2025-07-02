import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wellth_app/components/text_field.dart';
import 'package:wellth_app/components/wall_post.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final currentUser = FirebaseAuth.instance.currentUser!;

  // Text Controller
  final textController = TextEditingController();

  //sign out user
  void signOut (){
    FirebaseAuth.instance.signOut();
  }

  //postMessage
  void postMessage(){
    //Only post if there is something in the text field
    if (textController.text.isNotEmpty){
      FirebaseFirestore.instance.collection('User Qoutes').add({
        'UserEmail': currentUser.email,
        'Message': textController.text,
        'TimeStamp': Timestamp.now(),
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SizedBox.expand(
        child: Stack(
          children: [
            //top background/appbar
            Container(
              height: 220,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/profile-background.jpeg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                actions: [
                  IconButton(
                    onPressed: signOut,
                    icon: const Icon(Icons.logout),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 150, // overlaps AppBar
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      offset: Offset(0, -2),
                    ),
                  ],
                ),
                //actual profile attributes
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // profile picture
Stack(

      alignment: Alignment.center,
      children: [
        // Background image
        Image.asset(
          "assets/profile-picture-border.png",
          width: 200,
          height: 200,
          fit: BoxFit.cover,
        ),

        // Positioned Profile Picture with black & white outline
        Positioned(
          bottom: 30, 
          left: 20,
          child: Container(
            padding: const EdgeInsets.all(4), // Black outer ring
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.black,
            ),
            child: Container(
              padding: const EdgeInsets.all(4), // White inner ring
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: CircleAvatar(
                radius: 63,
                child: Icon(
                  Icons.person,
                  size:40,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    ),

                    //logged in as -- should display username will implement later
                    Container(
                      alignment: Alignment.topCenter,
                      child: Text(
                        '@${currentUser.email}',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold), // Optional: for multi-line text alignment
                      ),
                    ),

                    Expanded(
                      child: StreamBuilder(
                        stream: FirebaseFirestore.instance
                          .collection("User Qoutes")
                          .orderBy(
                            "TimeStamp", 
                            descending: true,
                          ).snapshots(), 
                          builder: (context, snapshot){
                            if(snapshot.hasData){
                              return ListView.builder(
                                itemCount: snapshot.data!.docs.isEmpty ? 0 : 1,
                                //itemCount:snapshot.data!.docs.length,
                                itemBuilder: (context, index) {
                                  //get qoute
                                  final post = snapshot.data!.docs[index];
                                  return WallPost(
                                    message: post['Message'], 
                                    //time: post[], 
                                    //update to username
                                    user: post['UserEmail'],
                                    currentProfileUser: currentUser.email.toString(),
                                  );
                                }
                              );
                            } else if (snapshot.hasError){
                              return Center(
                                child: Text('Error: '+snapshot.error.toString())
                              );
                            }
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          },
                      ),
                    ),

                    //Post Message
                    Padding(
                      padding: const EdgeInsets.all(25),
                      child: Row(
                        children: [
                          Expanded(
                            child: MyTextField(
                              controller: textController,
                              hintText: 'Post your favorite qoute',
                              obscureText: false,
                            ),
                          ),
                          IconButton(
                            onPressed: postMessage, 
                            icon: const Icon(Icons.arrow_circle_up))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

