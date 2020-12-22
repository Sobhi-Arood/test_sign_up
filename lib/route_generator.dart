import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_sign_up/misc/multiple_text_fields.dart';
import 'package:test_sign_up/view/sign_in_page.dart';
import 'package:test_sign_up/view/sign_up_page.dart';
import 'package:test_sign_up/view/welcome_page.dart';

import 'misc/image_file.dart';

class RouteNames {
  static const String loginPage = 'login_page';
  static const String regPage = 'reg_page';
}

class RoutesGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => WelcomePage());

      case RouteNames.loginPage:
        return MaterialPageRoute(builder: (_) => SignInPage());

      case RouteNames.regPage:
        return MaterialPageRoute(
            builder: (_) => MultiProvider(providers: [
                  ChangeNotifierProvider(
                      create: (context) => AddAddressField()),
                  ChangeNotifierProvider(
                      create: (context) => AddPhoneNumberField()),
                  ChangeNotifierProvider(create: (context) => AddImage()),
                ], child: SignUpPage()));

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
      );
    });
  }
}
