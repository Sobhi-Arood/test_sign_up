import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_sign_up/services/auth_service.dart';

import 'sign_in_page.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthServices auth = Provider.of<AuthServices>(context);
    return StreamBuilder<User>(
      stream: auth.onAuthStateChanged(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.data == null) {
            return SignInPage();
          }
          // to home page
          return Scaffold(
              appBar: AppBar(
                title: Text('Welcome'),
              ),
              body: Center(
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Column(
                    children: [
                      Text(
                        'Welcome ${snapshot.data.email}',
                        style: TextStyle(fontSize: 26.0),
                      ),
                      FlatButton(
                        child: Text(
                          'Sign out',
                          style: TextStyle(
                              fontSize: 20.0, color: Colors.blueAccent),
                        ),
                        onPressed: () async {
                          await auth.logout();
                          // Navigator.of(context).pushNamed('/login');
                        },
                      )
                    ],
                  ),
                ),
              ));
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
