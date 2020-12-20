import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_sign_up/misc/multiple_text_fields.dart';

import 'customs.dart';

class PhoneNumberTextField extends StatefulWidget {
  @override
  _PhoneNumberTextFieldState createState() => _PhoneNumberTextFieldState();
}

class _PhoneNumberTextFieldState extends State<PhoneNumberTextField> {
  final TextEditingController _phoneNumberController = TextEditingController();
  final int _fieldsLimit = 3;
  String phoneNumber;

  @override
  Widget build(BuildContext context) {
    final addPhoneNumber = Provider.of<AddPhoneNumberField>(context);
    return Container(
      child: Column(
        children: [
          Consumer<AddPhoneNumberField>(builder: (context, tf, _) {
            return ListView.builder(scrollDirection: Axis.vertical,
    shrinkWrap: true, physics: NeverScrollableScrollPhysics(), itemCount: tf.phoneNumbers.length, itemBuilder: (context, index) {
              return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(boxShadow: [customBoxShadow]),
                child: TextFormField(
                  controller: _phoneNumberController,
                  style: Theme.of(context).textTheme.bodyText1,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      hintText: 'phone number'.toUpperCase(),
                      hintStyle: Theme.of(context).textTheme.bodyText2,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 20.0),
                      border: InputBorder.none),
                  validator: (value) =>
                      value.isEmpty ? 'Please enter your phone number' : null,
                  onSaved: (value) => addPhoneNumber.phoneNumbers.add(value),
                ),
              ),
            );
            });
          },),
          Container(width: double.infinity, child: RaisedButton(child: Text('Add another phone number'), onPressed: () async {
            if (addPhoneNumber.phoneNumbertextFields.length < _fieldsLimit) {
              await addPhoneNumber.addTextField('');
            }
          }))
        ],
      ),
    );
  }
}