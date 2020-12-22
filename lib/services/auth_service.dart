import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AuthServices with ChangeNotifier {
  static AuthServices instance = AuthServices();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<User> onAuthStateChanged() {
    return _auth.authStateChanges();
  }

  Future<String> registerUser(String email, String password) async {
    try {
      var u = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return u.user.uid;
    } catch (e) {
      print(e);
      throw new Error();
    }
  }

  Future<void> loginUser(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      print(e);
      throw new Error();
    }
  }

  Future<User> getCurrentUser() async {
    try {
      return _auth.currentUser;
    } catch (e) {
      print(e);
      throw new Error();
    }
  }

  Future logout() async {
    var result = FirebaseAuth.instance.signOut();
    notifyListeners();
    return result;
  }
}
