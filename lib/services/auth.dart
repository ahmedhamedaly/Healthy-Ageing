import 'package:Healthy_Ageing/models/user.dart';
import 'package:Healthy_Ageing/screens/wrapper.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  // '_' underscore means its private to that class
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged
        //.map((FirebaseUser user) => _userFromFirebaseUser(user));
        .map(_userFromFirebaseUser);
  }

  //SIGN IN ANON
  // FUTURE:
  //                  UNCOMPLETED
  //           --------------------------
  //           |                        |
  //           |                        |
  // COMPLETED WITH DATA        COMPLETED WITH ERROR
  Future signInAnon() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      return _userFromFirebaseUser(result.user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // REGISTER WITH EMAIL & PASSWORD
  Future register(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return _userFromFirebaseUser(result.user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // LOGIN WITH EMAIL & PASSWORD
  Future login(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return _userFromFirebaseUser(result.user);
    } catch (e) {
      //print(e.toString());
      return null;
    }
  }

  Future signIn(AuthCredential authCreds) async {

    AuthResult result = await _auth.signInWithCredential(authCreds);
    uid = result.user.uid;
  }

  signInWithOTP(smsCode, verId){
    AuthCredential authCreds = PhoneAuthProvider.getCredential(
        verificationId: verId, smsCode: smsCode);
    signIn(authCreds);
  }


  //SIGN OUT
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}