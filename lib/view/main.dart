
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainPage extends StatelessWidget{
  MainPage({this.email});
  final String email;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text("Main Page")
    ),
    body: Column(
      children: <Widget>[
        Text(email),
        FlatButton(
          child: Text("Logout"),
          onPressed: (){
            FirebaseAuth.instance.signOut();
          }
        )
      ],
    )
  );
}