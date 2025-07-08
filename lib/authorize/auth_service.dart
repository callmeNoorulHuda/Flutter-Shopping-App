import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  Future<String?> signup(String email, String password, String role) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({
            'email': email,
            'role': role, // 'buyer' or 'seller'
          });
      return "Signup successful";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        return "Email already in use";
      } else if (e.code == 'weak-password') {
        return "Weak password (at least 6 characters)";
      } else if (e.code == 'invalid-email') {
        return "Invalid email format";
      } else {
        return "Signup failed: ${e.code}";
      }
    } catch (e) {
      return "Unexpected error";
    }
  }

  Future<String?> login(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .get();

      String role = snapshot['role'];
      return "Login successful:$role";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return "User not found";
      } else if (e.code == 'wrong-password') {
        return "Wrong password";
      } else if (e.code == 'invalid-email') {
        return "Invalid email format";
      } else {
        return "Login failed: ${e.code}";
      }
    } catch (e) {
      return "Unexpected error";
    }
  }
}
