import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:test_sign_up/model/User.dart';

class DBService {
  static DBService instance = DBService();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createUserIntoDB(UserEntity user) async {
    await _firestore.collection('Users').add(user.toJson());
  }
}