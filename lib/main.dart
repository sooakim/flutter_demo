import 'package:flutter/material.dart';
import 'package:flutter_demo/view/auth.dart';
import 'package:flutter_demo/view/splash.dart';
import 'package:provider/provider.dart';
import 'model/AuthState.dart';

void main() => runApp(DemoApp());

class DemoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashPage(),
    );
  }
}