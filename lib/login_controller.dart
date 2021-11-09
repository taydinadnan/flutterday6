import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutterday6/user_details.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginController with ChangeNotifier {
  final _googleSignIn = GoogleSignIn();
  GoogleSignInAccount? googleAccount;
  UserDetails? userDetails;

  googleLogin() async {
    googleAccount = await _googleSignIn.signIn();
    userDetails = UserDetails(
      displayName: googleAccount!.displayName,
      email: googleAccount!.email,
      photoUrl: googleAccount!.photoUrl,
    );
    notifyListeners();
  }

  facebookLogin() async {
    var result = await FacebookAuth.i.login(
      permissions: ["public_profile", "email"],
    );

    if (result.status == LoginStatus.success) {
      final requestData = await FacebookAuth.i.getUserData(
        fields: "email,name,picture",
      );

      userDetails = UserDetails(
        displayName: requestData["name"],
        email: requestData["email"],
        photoUrl: requestData["photoUrl"]["data"]["url"] ?? "",
      );
      notifyListeners();
    }
  }

  logOut() async {
    googleAccount = await _googleSignIn.signOut();
    await FacebookAuth.i.logOut();
    userDetails = null;
    notifyListeners();
  }
}
