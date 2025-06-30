import 'package:flutter/material.dart';

class WallPost extends StatelessWidget{
  final String message;
  final String user;
  //final String time;

  const WallPost({
    super.key,
    required this.message,
    //required this.time, --> time for community posts
    required this.user,
  });

  @override
  /*Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          //width: double.infinity,
          //height: double.infinity,
          padding: const EdgeInsets.all(25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,   // push to bottom
            crossAxisAlignment: CrossAxisAlignment.center, // center horizontally
            children: [
              Text(user,),
              Text(message,),
              SizedBox(height: 30), // space from bottom
            ],
          ),
        ),
      ),
    );
  }*/


  @override
  Widget build(BuildContext context) {
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