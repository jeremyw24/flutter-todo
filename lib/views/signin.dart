import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:todo/services/auth.dart';
import 'package:todo/widgets/app_bar.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  AuthService authService = new AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Widgets().mainAppBar(),
        body: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 6,
              ),
              Text("Flutter To Do Web App Demo",
                  style: TextStyle(fontSize: 21)),
              SizedBox(
                height: 16,
              ),
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {
                    authService.signInWithGoogle(context);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                        color: Color(0xffFF5964),
                        borderRadius: BorderRadius.circular(30)),
                    child: Text(
                      "Sign in with Google",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
