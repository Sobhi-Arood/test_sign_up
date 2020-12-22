import 'package:flutter/foundation.dart';
import '../services/db_service.dart';

class UserEntity {
  static const List<String> genders = ['Male', 'Female'];

  @required
  String userId = '';
  @required
  String firstName = '';
  @required
  String lastName = '';
  @required
  String email = '';
  @required
  List<String> phoneNumbers = [];
  @required
  List<String> address = [];
  @required
  String gender = genders.first;
  @required
  DateTime dateOfBirth = DateTime.now();
  @required
  String pictureUrl = '';

  // UserEntity({
  //   this.userId,
  //   this.firstName,
  //   this.lastName,
  //   this.email,
  //   this.phoneNumbers,
  //   this.address,
  //   this.gender,
  //   this.dateOfBirth,
  //   this.pictureUrl
  // });

  Map<String, dynamic> toJson() => {
        'user_id': userId,
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
        'phoneNumbers': phoneNumbers,
        'addresses': address,
        'gender': gender,
        'date_of_birth': dateOfBirth,
        'picture_url': pictureUrl
      };

  saveToDB() async {
    await DBService.instance.createUserIntoDB(this);
  }
}
