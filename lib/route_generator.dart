import 'package:flutter/material.dart';
import 'package:test_sign_up/main.dart';
import 'package:test_sign_up/view/sign_in_page.dart';
import 'package:test_sign_up/view/sign_up_page.dart';

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
        return MaterialPageRoute(builder: (_) => SignUpPage());

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