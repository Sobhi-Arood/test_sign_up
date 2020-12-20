import 'package:flutter/material.dart';

class AddPhoneNumberField extends ChangeNotifier {
  List<String> phoneNumberTextFields = [''];
  List<String> phoneNumbers = [];
  addTextField(String phoneNumber) async {
    phoneNumberTextFields.add(phoneNumber);
    notifyListeners();
  }
}

class AddAddressField extends ChangeNotifier {
  List<String> addressTextFields = [''];
  List<String> addresses = [];
  addTextField(String address) async {
    addressTextFields.add(address);
    notifyListeners();
  }
}