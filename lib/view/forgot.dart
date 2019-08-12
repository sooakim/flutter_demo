import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ForgotPage extends StatelessWidget{
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Forgot password")
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: _emailController,
              validator: (String value){
                if(value.isEmpty) return "Please input your email to reset";
                else return null;
              },
              decoration: InputDecoration(
                icon: Icon(Icons.email),
                labelText: "Email"
              ),
            ),
            FlatButton(
              child: Text("Reset"),
              onPressed: (){
                if(_formKey.currentState.validate()){
                  _resetPassword(_formKey.currentContext);
                }
              },
            )
          ],
        ),
      )
    );
  }

  void _resetPassword(BuildContext context) async{
    final String email = _emailController.text.toString();
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    Scaffold.of(context).showSnackBar(
      SnackBar(content: Text("Your password has been reseted!"))
    );
  }
}