import 'package:firebase_auth/firebase_auth.dart';

class FirebaseServices {
  static Future<String?> createAccount(
    String email,
    String password,
  ) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == "email-already-in-use") {
        return "email already in user";
      }
      if (e.code == "weak-password") {
        return "password is too weak";
      }
    } catch (e) {
      return e.toString();
    }
  }
}
