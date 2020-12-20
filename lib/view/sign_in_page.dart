import 'package:flutter/material.dart';
import 'package:test_sign_up/route_generator.dart';
import 'package:test_sign_up/services/auth_service.dart';
import 'package:test_sign_up/view/widgets/customs.dart';
import 'package:test_sign_up/view/widgets/login_button.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {

  final formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: SingleChildScrollView(child: Container(child: Form(key: formKey, child: Column(children: _listFormInputs(),),),),)
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  bool validateAndSave() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void validateAndSubmit() async {
    showDialog(
        context: context,
        builder: (context) => Center(child: CircularProgressIndicator()));
    if (validateAndSave()) {
      await AuthServices.instance.loginUser(_emailController.value.text, _passwordController.value.text);
      Navigator.of(context, rootNavigator: true).pop();
    }
  }

  List<Widget> _listFormInputs() {
      return [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(boxShadow: [customBoxShadow]),
            child: TextFormField(
              controller: _emailController,
              style: Theme.of(context).textTheme.bodyText1,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  hintText: 'email'.toUpperCase(),
                  hintStyle: Theme.of(context).textTheme.bodyText2,
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 20.0),
                  border: InputBorder.none),
              validator: (value) => value.isEmpty ? 'Please enter email' : null,
              // onSaved: (value) => _email = value,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(boxShadow: [customBoxShadow]),
            child: TextFormField(
              controller: _passwordController,
              style: Theme.of(context).textTheme.bodyText1,
              decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  hintText: 'password'.toUpperCase(),
                  hintStyle: Theme.of(context).textTheme.bodyText2,
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 20.0),
                  border: InputBorder.none),
              obscureText: true,
              validator: (value) =>
                  value.isEmpty ? 'Please enter password' : null,
              // onSaved: (value) => _password = value,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: LoginButton('sign in', validateAndSubmit),
        ),
        SizedBox(
          height: 30,
        ),
        FlatButton(
          child: Text('New user? Register'),
          onPressed: () => Navigator.of(context).pushNamed(RouteNames.regPage),
        ),
      ];
  }
}