import 'package:firebase_auth/firebase_auth.dart';

var auth = FirebaseAuth.instance;

class AuthenticationService {
  final FirebaseAuth _firebaseAuth;

  AuthenticationService(this._firebaseAuth);

//!authState chnages
  Stream<User?> get authStateChnages => _firebaseAuth.authStateChanges();

//! sign in functionality
  signIn(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return "Signed In";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  //! sign up from firebase
  signUp(String email, String password) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      print(e.message);
    }
  }

  //!singout
  singOut() async {
    try {
      await _firebaseAuth.signOut();
    } on FirebaseAuthException catch (e) {
      print(e.message);
    }
  }

  //!get the user who has signedin
  User? getUser() {
    try {
      return _firebaseAuth.currentUser;
    } on FirebaseAuthException catch (e) {
      return null;
    }
  }
}
