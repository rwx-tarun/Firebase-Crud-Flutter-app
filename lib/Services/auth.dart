import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crud/databasemanager/database_manage.dart';

class AuthenticationServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Register new User
  Future<dynamic> createNewUser(
      String name, String email, String password) async {
    try {
      var data = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await DataBaseManager()
          .createUserData(name, "Male", 100, data?.user?.uid ?? "");
      return data.user;
    } catch (e) {
      print(e.toString());
    }
  }

  // Login User
  Future<dynamic> loginUser(String email, String password) async {
    try {
      var data = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return data.user;
    } catch (e) {
      print(e.toString());
    }
  }

  // signout
  Future signOut() async {
    try {
      return _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
