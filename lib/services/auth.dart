import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:todo/services/database.dart';
import 'package:todo/views/home.dart';

class AuthService {
  Future<User> signInWithGoogle(BuildContext context) async {
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    final GoogleSignIn _googleSignIn = new GoogleSignIn();

    final GoogleSignInAccount _googleSignInAccount =
        await _googleSignIn.signIn();

    final GoogleSignInAuthentication googleSignInAuthentication =
        await _googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);

    UserCredential result =
        await _firebaseAuth.signInWithCredential(credential);

    User userDetails = result.user;

    if (result == null) {
    } else {
      Map<String, String> userMap = {
        "userName": userDetails.displayName,
        "email": userDetails.email,
      };

      DatabaseServices().uploadUserInfo(userDetails.uid, userMap);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Home(
              userEmail: userDetails.email,
              username: userDetails.displayName,
              userId: userDetails.uid),
        ),
      );
    }

    return userDetails;
  }
}
