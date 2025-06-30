import 'package:flutter/material.dart';

class WallPost extends StatelessWidget{
  final String message;
  final String user;
  //final String time;
  final String currentProfileUser; //---->remove for community posting?

  const WallPost({
    super.key,
    required this.message,
    //required this.time, --> time for community posts
    required this.user,
    required this.currentProfileUser,
  });


  @override
  Widget build(BuildContext context) {
    // Only show post if it belongs to the profile being viewed
    if (user != currentProfileUser) {
      return const SizedBox.shrink(); // Renders nothing
    }
    return Container(
      height: 550,
      decoration: BoxDecoration(
        //color: Colors.amber,
      ),
      alignment: Alignment.bottomLeft,
      margin: EdgeInsets.only(left: 25, right: 70),
      padding: EdgeInsets.all(25),
      //child: Row(
        //children: [
          child: Column
          (
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                user,
                style: TextStyle(color: Colors.blue),
              ),
              Text(
                message,
                textAlign: TextAlign.center,),
            ],
          )
        //],
      //),
    );
  }
}