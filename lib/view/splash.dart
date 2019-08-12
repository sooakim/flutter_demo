import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_demo/model/AuthState.dart';
import 'package:provider/provider.dart';

import 'auth.dart';
import 'main.dart';

class SplashPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) => StreamBuilder<FirebaseUser>(
    stream: FirebaseAuth.instance.onAuthStateChanged,
    builder: (context, snapshot){
      if(snapshot.data == null){
        return ChangeNotifierProvider<AuthState>.value(
          child: AuthPage(),
          value: AuthState()
        );
      }else{
        return MainPage(email: snapshot.data.email);
      }
    }
  );
}