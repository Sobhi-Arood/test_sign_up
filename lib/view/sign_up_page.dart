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

import '../model/User.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _user = UserEntity();
  final formKey = GlobalKey<FormState>();
  final TextEditingController _firstnameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(8.0),
            color: Colors.grey[200],
            child: Form(
              key: formKey,
              child: Column(
                children: _listFormInputs(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _firstnameController.dispose();
    _lastnameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _dateController.dispose();
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
        var date =
            "${picked.toLocal().day}/${picked.toLocal().month}/${picked.toLocal().year}";
        _dateController.text = date;
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
    if (validateAndSave()) {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => Center(
          child: CircularProgressIndicator(),
        ),
      );

      try {
        final userId = await AuthServices.instance.registerUser(
          _user.email,
          _passwordController.value.text,
        );
        _user.userId = userId;

        final imageUrl = await UploadService.instance.uploadImage(
          Provider.of<AddImage>(context).images[0],
        );
        _user.pictureUrl = imageUrl;

        await _user.saveToDB();

        Navigator.of(context, rootNavigator: true)
            .popUntil((route) => route.isFirst);
      } catch (e) {
        print(e.toString());
        Navigator.of(context).pop();
        showDialog(
          barrierDismissible: true,
          context: context,
          builder: (context) => Center(
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.all(16),
              child: Text(
                e.toString(),
                style: TextStyle(fontSize: 10),
              ),
            ),
          ),
        );
      }
    }
  }

  List<Widget> _listFormInputs() {
    return [
      TextFormField(
          controller: _firstnameController,
          style: Theme.of(context).textTheme.bodyText1,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              hintText: 'first name'.toUpperCase(),
              hintStyle: Theme.of(context).textTheme.bodyText2,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
              border: InputBorder.none),
          validator: (value) =>
              value.isEmpty ? 'Please enter your first name' : null,
          onSaved: (value) => {
                setState(() {
                  _user.firstName = value;
                })
              }),
      SizedBox(
        height: 16,
      ),
      TextFormField(
        controller: _lastnameController,
        style: Theme.of(context).textTheme.bodyText1,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            hintText: 'last name'.toUpperCase(),
            hintStyle: Theme.of(context).textTheme.bodyText2,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            border: InputBorder.none),
        validator: (value) =>
            value.isEmpty ? 'Please enter your last name' : null,
        onSaved: (value) => {
          setState(() {
            _user.lastName = value;
          })
        },
      ),
      SizedBox(
        height: 16,
      ),
      TextFormField(
        controller: _emailController,
        style: Theme.of(context).textTheme.bodyText1,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            hintText: 'email'.toUpperCase(),
            hintStyle: Theme.of(context).textTheme.bodyText2,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            border: InputBorder.none),
        validator: (value) => value.isEmpty ? 'Please enter email' : null,
        onSaved: (value) => {
          setState(() {
            _user.email = value;
          })
        },
      ),
      SizedBox(
        height: 16,
      ),
      TextFormField(
        controller: _passwordController,
        style: Theme.of(context).textTheme.bodyText1,
        decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            hintText: 'password'.toUpperCase(),
            hintStyle: Theme.of(context).textTheme.bodyText2,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            border: InputBorder.none),
        obscureText: true,
        validator: (value) => value.isEmpty ? 'Please enter password' : null,
        onSaved: (value) => {},
      ),
      SizedBox(
        height: 16,
      ),
      PhoneNumberTextField(this._user),
      SizedBox(
        height: 16,
      ),
      AddressTextField(this._user),
      SizedBox(
        height: 16,
      ),
      DropdownButtonFormField(
        decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            border: InputBorder.none),
        dropdownColor: Colors.white,
        elevation: 2,
        value: _user.gender,
        onChanged: (v) {
          setState(() {
            _user.gender = v;
          });
        },
        items: UserEntity.genders
            .map((v) => DropdownMenuItem(
                  child: Text(v),
                  value: v,
                ))
            .toList(),
      ),
      SizedBox(
        height: 16,
      ),
      GestureDetector(
        onTap: () => selectDate(context),
        child: AbsorbPointer(
          child: TextFormField(
            controller: _dateController,
            style: Theme.of(context).textTheme.bodyText1,
            decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                hintText: 'Birth of date'.toUpperCase(),
                hintStyle: Theme.of(context).textTheme.bodyText2,
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 20.0),
                border: InputBorder.none),
            validator: (value) =>
                value.isEmpty ? 'Please choose your birth of date' : null,
            onSaved: (value) => {_user.dateOfBirth = selectedDate},
          ),
        ),
      ),
      SizedBox(
        height: 16,
      ),
      ImagePickerButton(),
      SizedBox(
        height: 32,
      ),
      LoginButton('sign up', validateAndSubmit),
    ];
  }
}
