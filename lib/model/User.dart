// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class UserEntity {
  @required String userId;
  @required String firstName;
  @required String lastName;
  @required String email;
  @required List<String> phoneNumbers;
  @required List<String> address;
  @required String gender;
  @required DateTime dateOfBirth;
  @required String pictureUrl;

  UserEntity({
    this.userId,
    this.firstName,
    this.lastName,
    this.email,
    this.phoneNumbers,
    this.address,
    this.gender,
    this.dateOfBirth,
    this.pictureUrl
  });

  Map<String, dynamic> toJson() => {
    'user_id': userId, 'first_name': firstName, 'last_name': lastName, 'email': email, 'phoneNumbers': phoneNumbers, 'addresses': address, 'gender': gender, 'date_of_birth': dateOfBirth, 'picture_url': pictureUrl
  }; 
}