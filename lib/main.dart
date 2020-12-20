import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_sign_up/misc/image_file.dart';
import 'package:test_sign_up/misc/multiple_text_fields.dart';
import 'package:test_sign_up/route_generator.dart';
import 'package:test_sign_up/services/auth_service.dart';
import 'package:test_sign_up/view/sign_in_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(AppWidget());
}

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<User>.value(value: FirebaseAuth.instance.authStateChanges()),
        ChangeNotifierProvider(create: (context) => AuthServices()),
        ChangeNotifierProvider(create: (context) => AddAddressField()),
        ChangeNotifierProvider(create: (context) => AddPhoneNumberField()),
        ChangeNotifierProvider(create: (context) => AddImage()),
      ],
      child: MaterialApp(
        title: 'Test sign up',
        initialRoute: '/',
        onGenerateRoute: RoutesGenerator.generateRoute,
    ));
  }
}

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Welcome')),
      body: StreamBuilder<User>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {

          if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.data == null) {
            return SignInPage();
          }
          // to home page
return Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            children: [
              Text('Welcome ${snapshot.data.email}', style: TextStyle(fontSize: 26.0),),
              FlatButton(child: Text('Sign out', style: TextStyle(fontSize: 20.0, color: Colors.blueAccent),), onPressed: () async {
                await AuthServices.instance.logout();
                // Navigator.of(context).pushNamed('/login');
              },)
            ],
          ),
        ),
      );
        } else {
          return Center(child: CircularProgressIndicator(),);
        }
        },
      )
    );
  }
}