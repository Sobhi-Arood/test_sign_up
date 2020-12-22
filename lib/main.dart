import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_sign_up/route_generator.dart';
import 'package:test_sign_up/services/auth_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(AppWidget());
}

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AuthServices(),
      child: MaterialApp(
        title: 'Test sign up',
        initialRoute: '/',
        onGenerateRoute: RoutesGenerator.generateRoute,
      ),
    );
  }
}
