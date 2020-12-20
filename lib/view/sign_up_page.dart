import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_sign_up/misc/image_file.dart';
import 'package:test_sign_up/misc/multiple_text_fields.dart';
import 'package:test_sign_up/model/User.dart';
import 'package:test_sign_up/services/auth_service.dart';
import 'package:test_sign_up/services/db_service.dart';
import 'package:test_sign_up/services/upload_service.dart';
import 'package:test_sign_up/view/widgets/address_text_field.dart';
import 'package:test_sign_up/view/widgets/image_picker_button.dart';
import 'package:test_sign_up/view/widgets/login_button.dart';
import 'package:test_sign_up/view/widgets/phone_number_textfield.dart';

import 'widgets/customs.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  final formKey = GlobalKey<FormState>();
  final TextEditingController _firstnameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  String gender = 'Male';
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(title: Text('Register'),),
      body: SingleChildScrollView(
        child: Container(child: Form(key: formKey, child: Column(children: _listFormInputs(),),)),),
    );
  }

  @override
  void dispose() {
    _firstnameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  selectDate(BuildContext context) async {
  final DateTime picked = await showDatePicker(
    context: context,
    initialDate: selectedDate, // Refer step 1
    firstDate: DateTime(2000),
    lastDate: DateTime(2025),
  );
  if (picked != null && picked != selectedDate)
    setState(() {
      selectedDate = picked;
    });
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
      AuthServices.instance.registerUser(_emailController.value.text, _passwordController.value.text).then((value) {
        UploadService.instance.uploadImage(Provider.of<AddImage>(context).images[0]).then((value) {
          var user = UserEntity(userId: value, firstName: _firstnameController.value.text, lastName: _lastnameController.value.text, email: _emailController.value.text, phoneNumbers: Provider.of<AddPhoneNumberField>(context).phoneNumbers, address: Provider.of<AddAddressField>(context).addresses, gender: gender, dateOfBirth: selectedDate, pictureUrl: value);
        DBService.instance.createUserIntoDB(user).then((value) {
          Navigator.of(context, rootNavigator: true).pop();
        });
        });
      });
    }
  }

  List<Widget> _listFormInputs() {
      return [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(boxShadow: [customBoxShadow]),
            child: TextFormField(
              controller: _firstnameController,
              style: Theme.of(context).textTheme.bodyText1,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  hintText: 'first name'.toUpperCase(),
                  hintStyle: Theme.of(context).textTheme.bodyText2,
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 20.0),
                  border: InputBorder.none),
              validator: (value) =>
                  value.isEmpty ? 'Please enter your first name' : null,
              // onSaved: (value) => _username = value,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(boxShadow: [customBoxShadow]),
            child: TextFormField(
              controller: _lastnameController,
              style: Theme.of(context).textTheme.bodyText1,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  hintText: 'last name'.toUpperCase(),
                  hintStyle: Theme.of(context).textTheme.bodyText2,
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 20.0),
                  border: InputBorder.none),
              validator: (value) =>
                  value.isEmpty ? 'Please enter your last name' : null,
              // onSaved: (value) => _username = value,
            ),
          ),
        ),
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
        PhoneNumberTextField(),
        AddressTextField(),
        Padding(
          padding: const EdgeInsets.all(8),
          child: DropdownButtonFormField(
            elevation: 2,
            value: gender,
            onChanged: (v) {
              setState(() {
                gender = v;
              });
            },
            items: [
              DropdownMenuItem(value: 'Male', child: Text('Male'),),
              DropdownMenuItem(value: 'Female', child: Text('Female'),),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: RaisedButton(child: Text('Date of birth'), onPressed: () => selectDate(context)),
        ),
        ImagePickerButton(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: LoginButton('sign up', validateAndSubmit),
        ),
      ];
  }
}