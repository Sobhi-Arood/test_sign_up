import 'package:flutter/material.dart';


class AddPhoneNumberField extends ChangeNotifier {
  List<String> phoneNumbers = [''];
  addTextField(String phoneNumber) async {
    // PhoneNumber pn = PhoneNumber(phoneNumber);
    phoneNumbers.add(phoneNumber);
    notifyListeners();
  }
}

class AddAddressField extends ChangeNotifier {
  List<String> addresses = [''];
  addTextField(String address) async {
    addresses.add(address);
    notifyListeners();
  }
}