import 'package:flutter/material.dart';
import 'package:flutterday6/login_controller.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
    return Consumer<LoginController>(
      builder: (context, model, child) {
        if (model.userDetails != null) {
          return loggedInUI(model);
        } else {
          return loginControls(context);
        }
      },
    );
  }

  loggedInUI(LoginController model) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: CircleAvatar(
            backgroundImage: Image.network(
              model.userDetails!.photoUrl ?? '',
            ).image,
            radius: 50,
          ),
        ),
        Text(model.userDetails!.displayName ?? ''),
        Text(model.userDetails!.email ?? ''),
        ActionChip(
          avatar: const Icon(Icons.logout),
          label: const Text('Logout'),
          onPressed: () {
            Provider.of<LoginController>(context, listen: false).logOut();
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
              Provider.of<LoginController>(context, listen: false)
                  .googleLogin();
            },
          ),
          const SizedBox(height: 10),
          GestureDetector(
            child: Image.asset(
              "assets/login-button-png-18026.png",
              width: 250,
            ),
            onTap: () {
              Provider.of<LoginController>(context, listen: false)
                  .facebookLogin();
            },
          ),
        ],
      ),
    );
  }
}
