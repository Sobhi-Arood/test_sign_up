import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AuthServices with ChangeNotifier {
  static AuthServices instance = AuthServices();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> registerUser(String email, String password) async {
    try {
      var u = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return u.user.uid;
    } catch (e) {
      print(e);
      return '';
    }
  }

  Future<void> loginUser(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      print(e);

    }
  }

  Future<User> getCurrentUser() async {
    try {
      return _auth.currentUser;
    } catch(e) {
      print(e);
      throw new Error();
    }
  }

  Future logout() async {
    var result = FirebaseAuth.instance.signOut();
    notifyListeners();
    return result;
  }

  // Future<UserEntity> user() async {
  //   try {
  //     var currentUser = await getCurrentUser();
  //   var gett = await FirebaseFirestore.instance.collection('Users').doc(currentUser.uid.toString()).get();
  //   var user = UserEntity.fromSnapshot(gett);
  //   notifyListeners();
  //   return user;
  //   } catch (e) {
  //     throw new Error();
  //   }
  // }
}