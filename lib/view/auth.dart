
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/view/forgot.dart';
import 'package:provider/provider.dart';

import '../model/AuthState.dart';
import '../main.dart';

class CircularBackgroundPainer extends CustomPainter{
  CircularBackgroundPainer({@required this.color});
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint _paint = Paint()..color = color;
    final _dx = size.width * 0.5;
    double _dy = 0;
    double _radius = 0;
    if (size.width > size.height){
      _dy = size.height * -0.55;
      _radius = size.width * 0.7;
    }else{
      _dy = size.height * 0.2;
      _radius = size.height * 0.5;
    }
    canvas.drawCircle(Offset(_dx, _dy), _radius, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class AuthPage extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          CustomPaint(
            size: size,
            painter: CircularBackgroundPainer(color: Provider.of<AuthState>(context).color),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              _logoImage,
              Stack(
                children: <Widget>[
                  _inputForm(size),
                  _signInButton(size)
                ],
              ),
              SizedBox(height: size.height * 0.10),
              Consumer<AuthState>(
                builder: (context, AuthState state, child) => GestureDetector(
                  child: Text(
                    state.isRegister ? "Already have an acount? Login here" : "Do not have an account? Register here",
                    style: TextStyle(
                      color: state.color
                    )
                  ),
                  onTap: (){
                    state.toggle();
                  },
                )
              ),
              SizedBox(height: size.height * 0.05)
            ],
          )
        ],
      ),
    );
  }

  void _login(BuildContext context) async{
    final String email = _emailController.text.toString();
    final String password = _passwordController.text.toString();
    final AuthResult result = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email, password: password
    );
    if(result.user == null){
      Scaffold.of(context).showSnackBar(
        SnackBar(content: Text("Please try again"))
      );
    }else{
      // Navigator.push(context, MaterialPageRoute(builder: (context) => 
      //   MainPage(email: result.user.email)
      // ));
    }
  }

  void _register(BuildContext context) async{
    final String email = _emailController.text.toString();
    final String password = _passwordController.text.toString();
    final AuthResult result = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email, password: password
    );
    if(result.user == null){
      Scaffold.of(context).showSnackBar(
        SnackBar(content: Text("Please try again"))
      );
    }else{
      // Navigator.push(context, MaterialPageRoute(builder: (context) => 
      //   MainPage(email: result.user.email)
      // ));
    }
  }

  Widget get _logoImage => Expanded(
    child: Padding(
      padding: const EdgeInsets.only(top: 40, left: 24, right: 24),
      child: FittedBox(
        fit: BoxFit.contain,
        child: CircleAvatar(
          backgroundImage: NetworkImage("https://picsum.photos/200"),
        ),
      ),
    ),
  );

  Widget _signInButton(Size size) => Positioned(
    left: size.width * 0.15,
    right: size.width * 0.15,
    bottom: 0,
    child: SizedBox(
      height: 50,
      child: Consumer<AuthState>(
        builder: (context, state, child) => RaisedButton(
          color: state.color,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          child: Text(
            state.isRegister ? "Register" : "Login",
            style: TextStyle(fontSize: 20, color: Colors.white)
          ),
          onPressed: (){
            if(_formKey.currentState.validate()){
              state.isRegister ? _register(context) : _login(context);
            }
          },
        ),
      ),
    ),
  );

  Widget _inputForm(Size size) => Padding(
    padding: EdgeInsets.all(size.width * 0.05),
    child: Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 12,
          right: 12,
          top: 12,
          bottom: 32
        ),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: _emailController,
                validator: (String value){
                  if(value.isEmpty) return "Please input your email";
                  else return null;
                },
                decoration: InputDecoration(
                  icon: Icon(Icons.account_circle),
                  labelText: "Email"
                ),
              ),
              TextFormField(
                obscureText: true,
                controller: _passwordController,
                validator: (String value){
                  if(value.isEmpty) return "Please input your password";
                  else return null;
                },
                decoration: InputDecoration(
                  icon: Icon(Icons.vpn_key),
                  labelText: "Password"
                ),
              ),
              SizedBox(height: 8),
              Consumer<AuthState>(
                builder: (context, state, child) => Opacity(
                  opacity: state.isRegister ? 0 : 1,
                  child: GestureDetector(
                    child: Text("Forgot password?"),
                    onTap: state.isRegister ? null : (){
                      _navigateToForgot(context);
                    },
                  ),
                )
              ),
            ],
          ),
        ),
      ),
    ),
  );

  void _navigateToForgot(BuildContext context){
    Navigator.push(context, MaterialPageRoute(builder: (context) =>
      ForgotPage()
    ));
  }
}