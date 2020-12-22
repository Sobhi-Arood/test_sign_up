import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_sign_up/misc/multiple_text_fields.dart';
import 'package:test_sign_up/model/User.dart';
import 'text_field_widget.dart';

class AddressTextField extends StatefulWidget {
  final UserEntity _user;
  AddressTextField(this._user);
  @override
  _AddressTextFieldState createState() => _AddressTextFieldState();
}

class _AddressTextFieldState extends State<AddressTextField> {
  final int _fieldsLimit = 3;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Consumer<AddAddressField>(
            builder: (context, tf, _) {
              return ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: tf.addressTextFields.length + 1,
                itemBuilder: (context, index) {
                  if (index == tf.addressTextFields.length) {
                    return Container(
                      width: double.infinity,
                      child: RaisedButton(
                        child: Text('Add another address'),
                        onPressed: () async {
                          if (tf.addressTextFields.length < _fieldsLimit) {
                            await tf.addTextField('');
                          }
                        },
                      ),
                    );
                  }
                  return Column(
                    children: [
                      TextFieldWidget(
                        title: 'Address',
                        validateMessage: 'Please enter your address',
                        keyboardType: TextInputType.streetAddress,
                        onSave: (value) {
                          // addAddressField.addresses.add(value);
                          widget._user.address.add(value);
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
