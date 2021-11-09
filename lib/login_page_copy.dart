import 'package:flutter/material.dart';
import 'package:flutterday6/facebook_signin_controller.dart';
import 'package:flutterday6/google_signin_controller.dart';
import 'package:provider/provider.dart';

class FacebookLoginPage extends StatefulWidget {
  const FacebookLoginPage({Key? key}) : super(key: key);

  @override
  _FacebookLoginPageState createState() => _FacebookLoginPageState();
}

class _FacebookLoginPageState extends State<FacebookLoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber[50],
      appBar: AppBar(
        title: const Text('Login'),
        backgroundColor: Colors.red,
      ),
      body: loginUI(),
    );
  }

  loginUI() {
    return Consumer<FacebookSignInController>(
      builder: (context, model, child) {
        if (model.userData != null) {
          return loggedInUI(model);
        } else {
          return loginControls(context);
        }
      },
    );
  }

  loggedInUI(FacebookSignInController model) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: CircleAvatar(
            backgroundImage:
                Image.network(model.userData!["picture"]["data"]["url"] ?? '')
                    .image,
            radius: 50,
          ),
        ),
        Text(model.userData!['displayName'] ?? ''),
        Text(model.userData!["email"]),
        ActionChip(
          avatar: const Icon(Icons.logout),
          label: const Text('Logout'),
          onPressed: () {
            Provider.of<FacebookSignInController>(context, listen: false)
                .logOut();
          },
        ),
      ],
    );
  }

  loginControls(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            child: Image.asset(
              "assets/google.png",
              width: 250,
            ),
            onTap: () {
              Provider.of<GoogleSignInController>(context, listen: false)
                  .login();
            },
          ),
          GestureDetector(
            child: Image.asset(
              "assets/login-button-png-18026.png",
              width: 250,
            ),
            onTap: () {
              Provider.of<FacebookSignInController>(context, listen: false)
                  .login();
            },
          ),
        ],
      ),
    );
  }
}
