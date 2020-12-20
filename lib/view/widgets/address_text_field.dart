import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_sign_up/misc/multiple_text_fields.dart';
import 'text_field_widget.dart';

class AddressTextField extends StatefulWidget {
  @override
  _AddressTextFieldState createState() => _AddressTextFieldState();
}

class _AddressTextFieldState extends State<AddressTextField> {
  final TextEditingController _addressController = TextEditingController();
  final int _fieldsLimit = 3;

  @override
  Widget build(BuildContext context) {
    final addAddressField = Provider.of<AddAddressField>(context);
    return Container(
      child: Column(
        children: [
          Consumer<AddAddressField>(builder: (context, tf, _) {
            return ListView.builder(scrollDirection: Axis.vertical,
    shrinkWrap: true, physics: NeverScrollableScrollPhysics(), itemCount: tf.addresses.length, itemBuilder: (context, index) {
        return TextFieldWidget(title: 'Address', onSave: (value) => addAddressField.addresses.add(value));
            //   return Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Container(
            //     decoration: BoxDecoration(boxShadow: [customBoxShadow]),
            //     child: TextFormField(
            //       controller: _addressController,
            //       style: Theme.of(context).textTheme.bodyText1,
            //       keyboardType: TextInputType.number,
            //       decoration: InputDecoration(
            //           fillColor: Colors.white,
            //           filled: true,
            //           hintText: 'Address'.toUpperCase(),
            //           hintStyle: Theme.of(context).textTheme.bodyText2,
            //           contentPadding: const EdgeInsets.symmetric(
            //               horizontal: 10.0, vertical: 20.0),
            //           border: InputBorder.none),
            //       validator: (value) =>
            //           value.isEmpty ? 'Please enter an address' : null,
            //       onSaved: (value) => addAddressField.addresses.add(value),
            //     ),
            //   ),
            // );
            });
          },),
          Container(width: double.infinity, child: RaisedButton(child: Text('Add another address'), onPressed: () async { 
            if (addAddressField.addressTextFields.length < _fieldsLimit) {
await addAddressField.addTextField('');
            }
          }))
        ],
      ),
    );
  }
}