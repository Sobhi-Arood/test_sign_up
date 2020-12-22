import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_sign_up/misc/multiple_text_fields.dart';
import 'package:test_sign_up/model/User.dart';
import 'package:test_sign_up/view/widgets/text_field_widget.dart';

class PhoneNumberTextField extends StatefulWidget {
  final UserEntity _user;
  PhoneNumberTextField(this._user);
  @override
  _PhoneNumberTextFieldState createState() => _PhoneNumberTextFieldState();
}

class _PhoneNumberTextFieldState extends State<PhoneNumberTextField> {
  final int _fieldsLimit = 3;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Consumer<AddPhoneNumberField>(
            builder: (context, tf, _) {
              return ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: tf.phoneNumberTextFields.length + 1,
                itemBuilder: (context, index) {
                  if (index == tf.phoneNumberTextFields.length) {
                    return Container(
                      width: double.infinity,
                      child: RaisedButton(
                        child: Text('Add another phone number'),
                        onPressed: () async {
                          if (tf.phoneNumberTextFields.length < _fieldsLimit) {
                            await tf.addTextField('');
                          }
                        },
                      ),
                    );
                  }
                  return Column(
                    children: [
                      TextFieldWidget(
                        title: 'phone number',
                        validateMessage: 'Please enter your phone number',
                        keyboardType: TextInputType.number,
                        onSave: (value) {
                          widget._user.phoneNumbers.add(value);
                        },
                      ),
                      SizedBox(
                        height: 8,
                      )
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
